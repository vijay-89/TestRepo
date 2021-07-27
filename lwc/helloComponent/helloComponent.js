import { LightningElement, track } from 'lwc';

export default class HelloComponent extends LightningElement {
    @track person = 'World';

    updatePerson(event) {
        this.person = event.target.value;
    }
}