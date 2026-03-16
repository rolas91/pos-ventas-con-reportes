import { v } from "../styles/variables";
import {
  AiOutlineHome,
  AiOutlineSetting,
} from "react-icons/ai";

export const DesplegableUser = [
  {
    text: "Mi perfil",
    icono: <v.iconoUser/>,
    tipo: "miperfil",
  },
  {
    text: "Configuracion",
    icono: <v.iconoSettings/>,
    tipo: "configuracion",
  },
  {
    text: "Cerrar sesión",
    icono: <v.iconoCerrarSesion/>,
    tipo: "cerrarsesion",
  },
];



//data SIDEBAR
export const LinksArray = [
  // {
  //   label: "Home",
  //   icon: "noto-v1:house",
  //   to: "/",
  // },
  // {
  //   label: "Dashboard",
  //   icon: "fluent-emoji-flat:antenna-bars",
  //   to: "/dashboard",
  // },
  {
    label: "Dashboard",
    icon: "fluent-emoji-flat:antenna-bars",
    to: "/",
  },
  {
    label: "VENDER",
    icon: "flat-color-icons:shop",
    to: "/pos",
  },
  {
    label: "Inventario",
    icon: "flat-ui:box",
    to: "/inventario",
  },
  {
    label: "Reportes",
    icon: "flat-ui:graph",
    to: "/reportes",
  },
 
];
export const SecondarylinksArray = [
 
  {
    label: "Configuración",
    icon:"icon-park:setting-two",
    to: "/configuracion",
    color:"#CE82FF"
  },
  {
    label: "Mi perfil",
    icon:"icon-park:avatar",
    to: "/miperfil",
    color:"#CE82FF"
  },
  
  

];
//temas
export const TemasData = [
  {
    icono: "🌞",
    descripcion: "light",
   
  },
  {
    icono: "🌚",
    descripcion: "dark",
    
  },
];

//data configuracion
export const DataModulosConfiguracion =[
  {
    title:"Productos",
    subtitle:"registra tus productos",
    icono:v.caja,
    link:"/configurar/productos",
   
  },
  {
    title:"Personal",
    subtitle:"ten el control de tu personal",
    icono:v.hombre,
    link:"/configurar/usuarios",
   
  },

  {
    title:"Tu empresa",
    subtitle:"configura tus opciones básicas",
    icono:v.administracion,
    link:"/configurar/empresa",
    
  },
  {
    title:"Categoria de productos",
    subtitle:"asigna categorias a tus productos",
    icono:v.categoria,
    link:"/configuracion/categorias",
    
  },
  {
    title:"Marca de productos",
    subtitle:"gestiona tus marcas",
    icono:v.piensaFueraDeLaCaja,
    link:"/configurar/marca",
   
  },
  

]
//tipo usuario
export const TipouserData = [
  {
    descripcion: "empleado",
    icono: "🪖",
  },
  {
    descripcion: "administrador",
    icono: "👑",
  },
];
//tipodoc
export const TipoDocData = [
  {
    descripcion: "Dni",
    icono: "🪖",
  },
  {
    descripcion: "Libreta electoral",
    icono: "👑",
  },
  {
    descripcion: "Otros",
    icono: "👑",
  },
];