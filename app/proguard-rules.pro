# Add project specific ProGuard rules here.
# You can control the set of applied configuration files using the
# proguardFiles setting in build.gradle.
#
# For more details, see
#   http://developer.android.com/guide/developing/tools/proguard.html

# If your project uses WebView with JS, uncomment the following
# and specify the fully qualified class name to the JavaScript interface
# class:
#-keepclassmembers class fqcn.of.javascript.interface.for.webview {
#   public *;
#}

# Uncomment this to preserve the line number information for
# debugging stack traces.
#-keepattributes SourceFile,LineNumberTable

# If you keep the line number information, uncomment this to
# hide the original source file name.
#-renamesourcefileattribute SourceFile
-----------------------------------------------------------

import * as React from 'react';
import { FlatList, View, Image, Alert } from 'react-native';
import { useEffect } from 'react';
import { Modal, Portal, Text, Button, Provider, HelperText, TextInput } from 'react-native-paper';


const App = () => {
  const [visible, setVisible] = React.useState(false);
  const [visible2, setVisible2] = React.useState(false);

  const showModal = () => setVisible(true);
  const hideModal = () => setVisible(false);
  const showModal2 = () => setVisible2(true);
  const hideModal2 = () => setVisible2(false);
  const containerStyle = { backgroundColor: 'white', padding: 20 };

  const [mesa, setMesa] = React.useState('');
  const [nombre, setNombre] = React.useState('');
  const [RUT, setRUT] = React.useState('');
  const [email, setEmail] = React.useState('');
  const [fecha, setFecha] = React.useState('');
  const [descripcion, setDescripcion] = React.useState('');

  const [pedidos, setPedidos] = React.useState([]);




  const [products, setProducts] = React.useState([]);

  useEffect(() => {
    getProducts()
  }, [])

  const getProducts = async () => {
    try {
      const res = await fetch('https://dummyjson.com/products');
      const json = await res.json();
      setProducts(json.products)
    } catch (error) {
      console.error(error);
    }
  };

  const hasErrorsMesa = () => {
    return isNaN(mesa)
  };
  const hasErrorsNombre = () => {
    return !isNaN(nombre);
  };
  const hasErrorsRUT = () => {
    return !RUT.includes('-');
  };
  const hasErrorsEmail = () => {
    return !email.includes('@');
  };
  const hasErrorsFecha = () => {
    return !fecha.includes('/');
  };

  const ingresarPedidos = () => {

    if (mesa == "" || nombre == "" || RUT == "" || email == "" || fecha == "") {

      Alert.alert("Error", "Algun campo esta vacio")
      return
    }

    const pedido = {
      id: new Date(),
      mesa,
      nombre,
      RUT,
      email,
      fecha,
      descripcion,
      estado: 'ingresado'
    }
    setPedidos([...pedidos, pedido])
    Alert.alert("Pedido Ingresado", "Su pedido fue agregado correctamente")
  }

  const eliminarPedido = (id) => {
    
    setPedidos(pedidos.filter(pedido => pedido.id !==id))

  }
  const canceladoPedido = (item) => {
   
    item.estado = 'Cancelado'
    hideModal(true)
  }
  const entregadoPedido = (item) => {
    
    item.estado = 'Entregado'
    hideModal(true)
  }

  return (

    <Provider>
      <Portal>
        <Modal visible={visible} onDismiss={hideModal} contentContainerStyle={containerStyle}>
          <FlatList
            data={pedidos}
            keyExtractor={(item => item.id)}
            renderItem={({ item }) => {

              return (
                <View style={{ flex: 1, flexDirection: "row", borderBottomWidth:1, borderBottomColor: 'black'}}>
                  <View style={{ flex: 1 }}>
                    <Text>Numero de mesa: {item.mesa}</Text>
                    <Text>Nombre: {item.nombre}</Text>
                    <Text>RUT:  {item.RUT}</Text>
                    <Text>Email: {item.email}</Text>
                    <Text>Fecha: {item.fecha}</Text>
                    <Text>Descripcion: {item.descripcion}</Text>
                    <Text>Estado: {item.estado}</Text>
                  </View>
                <View>
                  <Button onPress={() => eliminarPedido(item.id)}  style={{ borderRadius: 3, backgroundColor: 'green', padding: 1 , margin: 1}} >
                    <Text>Eliminar Pedido</Text>
                  </Button>
                  <Button onPress={() => canceladoPedido(item)} style={{borderRadius: 3, backgroundColor: 'green', padding: 1 , margin: 1}} >
                  <Text>Pedido Cancelado</Text>
                  </Button>
                  <Button onPress={() => entregadoPedido(item)} style={{ borderRadius: 3, backgroundColor: 'green', padding: 1, margin: 1}} >
                  <Text>Pedido Entregado</Text>
                  </Button>
                  </View>
                </View>
              )
            }
            }
          />

        </Modal>

        <Modal visible={visible2} onDismiss={hideModal2} contentContainerStyle={containerStyle}>
          <FlatList
            data={products}
            keyExtractor={(item => item.id)}
            renderItem={({ item }) => {

              return (

                <View style={{ flex: 1, flexDirection: "row", alignItems: 'flex-end' }}>
                  <View style={{ flex: 1 }}>
                    <Text>Nombre: {item.title}</Text>
                    <Text>Precio: {item.price}</Text>
                    <Text>Calificacion:  {item.rating}</Text>
                    <Text>Stock: {item.stock}</Text>
                    <Text>Categoria: {item.category}</Text>
                  </View>
                  <Image style={{ width: 80, height: 80 }} source={{ uri: item.images[0] }} />
                </View>

              )
            }
            }
          />
        </Modal>
      </Portal>
      <TextInput label="Numero de mesa" value={mesa} onChangeText={setMesa} />
      <HelperText type="error" visible={hasErrorsMesa()}>
        Numero de mesa invalido
      </HelperText>
      <TextInput label="Nombre del cliente" value={nombre} onChangeText={setNombre} />
      <HelperText type="error" visible={hasErrorsNombre()}>
        Nombre invalido
      </HelperText>
      <TextInput label="RUT" value={RUT} onChangeText={setRUT} />
      <HelperText type="error" visible={hasErrorsRUT()}>
        RUT invalido
      </HelperText>
      <TextInput label="Email" value={email} onChangeText={setEmail} />
      <HelperText type="error" visible={hasErrorsEmail()}>
        Email invalido
      </HelperText>
      <TextInput label="Fecha formato dd/mm/aa" value={fecha} onChangeText={setFecha} />
      <HelperText type="error" visible={hasErrorsFecha()}>
        Fecha invalida
      </HelperText>
      <TextInput label="Descricion del pedido" value={descripcion} onChangeText={setDescripcion} />

      <Button onPress={() => ingresarPedidos()} style={{ marginTop: 30 }} >
        Ingresar pedido
      </Button>
      <Button style={{ marginTop: 30 }} onPress={showModal}>
        Ver pedido
      </Button>
      <Button style={{ marginTop: 30 }} onPress={showModal2}>
        Ver catalogo
      </Button>
    </Provider>

  );
};

export default App;
