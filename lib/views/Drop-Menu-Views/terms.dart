import 'dart:convert';
import 'package:flutter_html/flutter_html.dart';
import 'package:harvest_driver/components/WaveAppBar/wave_appbar.dart';
import 'package:harvest_driver/helpers/Localization/localization.dart';

import 'package:flutter/material.dart';

import 'package:harvest_driver/helpers/api.dart';
import 'package:harvest_driver/helpers/colors.dart';
import 'package:harvest_driver/models/pages.dart';
import 'package:harvest_driver/widgets/Loader.dart';
import 'package:harvest_driver/widgets/home_popUp_menu.dart';
import 'package:http/http.dart';

class Terms extends StatefulWidget {
  @override
  _TermsState createState() => _TermsState();
}

class _TermsState extends State<Terms> {
  bool load = true;
  Pages _terms;

  getSettings() async {
    var request =
    await get(ApiHelper.api + 'getSetting', headers: ApiHelper.headers);
    var response = json.decode(request.body)['items'];
    Pages model = Pages.fromJson(response['terms']);
    setState(() {
      _terms = model;
      load = false;
    });
  }

  @override
  void initState() {
    getSettings();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: WaveAppBar(
        leading: SizedBox.fromSize(size: Size.zero),
        bottomViewOffset: Offset(0, -10),
        backgroundGradient: CColors.greenAppBarGradient(),
        actions: [HomePopUpMenu()],
      ),
      body: SafeArea(
        child: Column(
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Text(
                  "terms".trs(context),
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    color: CColors.headerText,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
            Expanded(
              child: ListView(
                padding: EdgeInsets.symmetric(horizontal: 20),
                children: [
                  load
                      ? Center(child: Loader())
                      : SingleChildScrollView(
                    child: Container(
                      width: size.width * .95,
                      child: Html(
                        data:
                        _terms.description.replaceAll("\\r\\n", '') ?? '',
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
