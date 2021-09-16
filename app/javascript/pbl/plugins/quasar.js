
import { Quasar, Notify } from "quasar";
import "quasar/dist/quasar.css";

export function initQuasar(app) {
  app.use(Quasar, {
    config: {
      brand: {
        primary: '#027BE3',
        secondary: '#26A69A',
        accent: '#9C27B0',
        dark: '#1D1D1D',
        positive: '#21BA45',
        negative: '#C10015',
        info: '#31CCEC',
        warning: '#F2C037',
      },
      globalProperties: {},
      // dark: true
    },
    plugins: {
      Notify
    }
  });
}
