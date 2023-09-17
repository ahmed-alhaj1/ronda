import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:provider/provider.dart';
import 'package:ronda/components/text_form_builder.dart';
import 'package:ronda/utils/firebase.dart';
import 'package:ronda/widgets/indicators.dart';

class CreateProposal extends StatefulWidget {
  @override
  _CreateProposalState craeteState() => _CreateProposalState();
}

class _CreateProposalState extends State<CreateProposal> {
  @override
  Widget build(BuildContext context) {
    ProposalViewModel pvm = Provider.of<ProposalViewModel>(context);
    return LoadingOverlay(
      child: Scaffold(
          body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 40.0),
        children: [
          SizedBox(height: MediaQuery.of(context).size.height / 10),
          Text(
            'Create a new proposal and connect with employers',
          ),
        ],
      )),
    );
  }

  buildForm(ProposalViewModel pvm, BuildContext context) {
    return Form(
      //key: pvm.key,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: Column(
        children: [
          TextFormBuilder(
            prefix: Ionicons.pin_outline,
            hintText: 'Years of Experience',
            textInputAction: TextInputAction.next,
            onSaved: (String val) {
              pvm.setName(val);
            },
          )
        ],
      ),
    );
  }
}
