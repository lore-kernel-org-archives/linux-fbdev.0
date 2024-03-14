Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2049.outbound.protection.outlook.com [40.107.94.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BEC35A0FD
	for <linux-fbdev@vger.kernel.org>; Thu, 14 Mar 2024 12:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710420493; cv=fail; b=pUImtiUGttCMsjordcoT1yhq0KyX93r9JVQUAkx08Nnz9duncKTN10gLzHMB/4XSN7HSaJuj1Z2b3QMiTCJpDhAj0cQM/FHvvepq2RICyA3JyjnKbcLnhNp0zy5S9xKABndtfV6EsfptQStcPWBfVg8bPmlL8rqW53BI9JjPnH8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710420493; c=relaxed/simple;
	bh=4WY1AvZo9R2p9D7J146g8M8jccq0mxa7/TDQf8joVHE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=KrsQI72Kfh2USDaZoU83WoQrydgWlbQEt2QweloSjC6FS2uguJ2Q80otdeJTJ4m5Sn+rzv/I2XOJl3O31wtwYeh+O7aGW7bkGdISrm26OfNxhRG4mofJjKWWA85PA96OIacHKHBmGPg7mMPeIUoGZ+QvDdJRnoVEQusedQYY+tU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asem.it; spf=pass smtp.mailfrom=asem.it; dkim=pass (2048-bit key) header.d=asem.it header.i=@asem.it header.b=BPQGXcTg; arc=fail smtp.client-ip=40.107.94.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asem.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=asem.it
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=asem.it header.i=@asem.it header.b="BPQGXcTg"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OBaeJDfdezR1PpKqnScis7oO2KGQua9If+F923cYX5AQ4p8YHEXAmklklidxhr1h8/VzY90Vt+WG1KX2MhFwal95dUll6A+dZu8hPUhsJ58XD+tBNLlwiivQWnk9dxYzTigyFyiqpgT0SG8pwK618Ll0oAKalHsjnkC/g0nxJmMmWHfAy7va9i7oKaythjYgjqNjDd22kEZJXu3aBf+yCauC1EZB21Srua48nmVdo/Tel1xD/nfierh2M8BbIazsE9w/vYSLL+RucXOafcIRUZ525/lGs6qp8DEH1lfK8y/ApeJtaEKpcrKll2g5uFDgQ1/W8UZh46v3VY4beoVc6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mh6lNc7pOrUKmI9HfUpXNbVrRxWa2ReqPD5RlDpDIv4=;
 b=FxFNg0VgGF3QCz6Qp8oSn5UGGRINIzMeS3A9Un/8D4/jbIhJHBfbW9fgWHLYvxk7Z0pDHV7tCO65/SZCsmHC69Kmupz+aCb9HPmvice2OldeMJ3Ff++/ZPp2seOiFl+7Du9q7nl94U7Ot9m3xMrprQ2qnH7lhKdtDoAzkYIm+VNWyrNdpvXsX7Zgu4GH4mC9TrI/kf1c6KPyM+0t9RrPn2Z5x9CWoMg0nC9kC445P0goJAqefAYhQz3neWyIXg8taHSkLoRm5eOwu0piybbWMKs3ZgfSPbY5LA4iY8vnfUkH8+k9+iaH+BwJC3m0Xrmqtgis/5mPj+WpQj2v5n7LMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=asem.it; dmarc=pass action=none header.from=asem.it; dkim=pass
 header.d=asem.it; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=asem.it; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mh6lNc7pOrUKmI9HfUpXNbVrRxWa2ReqPD5RlDpDIv4=;
 b=BPQGXcTg60waAzf2ExzaO7P20rPJrHV4PFJnLaqNNny8DdyGjE5f9Ha/ZHmsMC3xXt++OREpr4Echtx8U48DSceBMiXmlulo2CR5UQt+Ae9XdqLGPbJeIlQ+Ks1NhwFGP+7RNdGPWmAp6u2qNymD14sxJFjy0eAJ5sv9eW2WXJQADi9kava9SdtGlPRizzxVHlwUbbysCAn6CGoTVQ0d/VRTcQRiaj2LNqj/aGEv7EuS7cQ8UtDoLfDUrbsbor7Am0juvHEk4FXy5djjK+6/Ud2cyNV09p+mE3s073yVp5FGknA3xqRIDf6uGSn1QJMbOukDv/yddyMFMhx4+/1jrw==
Received: from PH0PR22MB3789.namprd22.prod.outlook.com (2603:10b6:510:29c::11)
 by MW4PR22MB3740.namprd22.prod.outlook.com (2603:10b6:303:1bb::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.20; Thu, 14 Mar
 2024 12:48:05 +0000
Received: from PH0PR22MB3789.namprd22.prod.outlook.com
 ([fe80::35ce:ff48:fa8b:d4a7]) by PH0PR22MB3789.namprd22.prod.outlook.com
 ([fe80::35ce:ff48:fa8b:d4a7%7]) with mapi id 15.20.7362.035; Thu, 14 Mar 2024
 12:48:05 +0000
From: FLAVIO SULIGOI <f.suligoi@asem.it>
To: 'Thomas Zimmermann' <tzimmermann@suse.de>, "lee@kernel.org"
	<lee@kernel.org>, "daniel.thompson@linaro.org" <daniel.thompson@linaro.org>,
	"jingoohan1@gmail.com" <jingoohan1@gmail.com>, "deller@gmx.de"
	<deller@gmx.de>
CC: "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
	"linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>,
	"linux-staging@lists.linux.dev" <linux-staging@lists.linux.dev>, Nicolas
 Ferre <nicolas.ferre@microchip.com>, Alexandre Belloni
	<alexandre.belloni@bootlin.com>, Claudiu Beznea <claudiu.beznea@tuxon.dev>
Subject: RE: [PATCH 6/6] backlight: Remove fb_blank from struct
 backlight_properties
Thread-Topic: [PATCH 6/6] backlight: Remove fb_blank from struct
 backlight_properties
Thread-Index: AQHadg3bN5HiBZ02nkGErYV+WgtSQA==
Date: Thu, 14 Mar 2024 12:48:04 +0000
Message-ID:
 <PH0PR22MB3789B2F1312E97EFFD8932FDF9292@PH0PR22MB3789.namprd22.prod.outlook.com>
References: <20240313154857.12949-1-tzimmermann@suse.de>
 <20240313154857.12949-7-tzimmermann@suse.de>
In-Reply-To: <20240313154857.12949-7-tzimmermann@suse.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=asem.it;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR22MB3789:EE_|MW4PR22MB3740:EE_
x-ms-office365-filtering-correlation-id: 53815148-9959-4b66-a21b-08dc4424fdeb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 HBlFhFxbAcWD0LiXXf4McZIdn3K5CaPKn27iRpSl5o3metX4VPj9CLUH0N4MTwPgix10bX3YOMpCxQCEOv0/Y5BK0+sw53h7BBWpVdYTQ01WkVCoz3Wk9k3lvZTQsVng4T8L4ewjAcQP/2G7lEnlk7o5e5CT5gnqW8/IG35IOyHOY3tIK1KkwZHGsaIRxFN2JBhDIr+1pfrlMlSTWebPahqHUwWxG+njd2MHL7PCoAVyVCvFX4eTFy1Y3P37IVQ2kds0kVsTqbphAER7eitkhkXwI19SgqCnyeQJkw11P29+0UF3EqV0ih1slKfebmyHICWp7nhLLUWbYUVa0+aljdsACqsI/SXnWtBwymmHQ0AIEsjhFjTRIglK1fyFAtZG3TT9ftffmWMzJRlhtmAEGMCc4Q4ZrWkPBGjmdJkf5oIIUB2zw71LPCDIJV9L89kTlPwRbVG6uE/kdh7FL73oR+c236sCHn2UgjetzMC2SPKpLtZVYx6790Hqr/2e9B7ro5WWWbfHRx8287sWBZwCffRuKZiPWM1UTHBMmIhBKqcYSETqXBwizXhP7lSCnZKdMfuxqas66VzDyKKxI9qO76fl794mTVoInK0sxZew0KjUJudyj/37UtS+hOQbWFN/z/6DNPkGoho5A3Vr5oOey8o+4gSCyH9g4uhO/6WBCVfZHRIHKgqkeACEnrP8zvP4bW2sUCNmslSt4Mcp6DJ1Tg==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR22MB3789.namprd22.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(7416005)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?SSgzRmn0hAuWgV8UF3IBJoFXu8SWMbdxAqf/fERkyK0700LxhEmo4Pujk8wl?=
 =?us-ascii?Q?+5BtNc6lcf8VqJ766K7oBGr59WwMuZJktoZw56bXUzV3zUWoCR1U9W/CpcD+?=
 =?us-ascii?Q?jwCaw05aKv6nEbMz/HU2UxX522WfKBx8Jj2SJ6ivkgj36b2Fh6iD7nROZ4Yn?=
 =?us-ascii?Q?lVRKlAzbjoc71yWPVyZ0bhFOZ2mqpaI5LW+Qv0cyYX+AWZaPxj2s+blVp3Db?=
 =?us-ascii?Q?UFoxHPg12RNH34vWYmiAbwMff3qtXjIMW2EmpY0nYDUAB+KdcTBOCY4/OjLp?=
 =?us-ascii?Q?D+NFNVtan1H9G2TaLIdNDX5Kr7w2J8HTDiD0wJMkqBlrxlXHaMgzvpg1j3P8?=
 =?us-ascii?Q?MqcAFdZOmMj11t6OdXpDUq8xlxTP217viyv5aztQeFx5YnoQzA2ulpEi954T?=
 =?us-ascii?Q?UI5Tg4sjDMSHUfDnMnTiTSF7JTW9tAZuA6IXV0vPh0KjJyZTwNU0OWJesR23?=
 =?us-ascii?Q?ChWzWMUbIZIwXIaGoEugkNZZSdRpc/t4o2oW2VnVaPI56JH3Mk4EbT0k/Lpi?=
 =?us-ascii?Q?F8MDBma/XhAYU3uQvd2C/11cgYFUVmm3eNoQBgQgDohl49M+4C/ww7KPuek2?=
 =?us-ascii?Q?ZaN3o20RWoH6e9QMZebyw/8oSbI8J40jRrGi4w7d67KllUtlqcqMn1HiT7Ye?=
 =?us-ascii?Q?sTevP37bRAMpPZMl5ExUfA+bj3CukwjQsSysJkSK9TIDWf9zhsPMiJQIWiyN?=
 =?us-ascii?Q?LriS6U/FhvRlFyRQSskMrumGBOwaAeQ+OkzniAnx0mmy+hM2TLaGZjrLrAjk?=
 =?us-ascii?Q?w8HoIcUG3tnb4PaE1VfC6R2niRUlS1He3WmOPq6RTibKW5EpFJ/Jnd5Cva+w?=
 =?us-ascii?Q?Vvx5Tgev/FDRmRp4eZNCk/i9tgc/f8c4vqgloyDq0ei0cDpgBIG3GV+CDKAg?=
 =?us-ascii?Q?nQcb2jRg7TAMe6STsTn+2K9dxkcRjnacf/Yi7KSITLGXBWfSF0u0X3MYGOn4?=
 =?us-ascii?Q?U9dpFbe7jZadE4LktORKafEVkc5aLLCY+RdJv0yvms2sAooUC3WKp47lj7zU?=
 =?us-ascii?Q?/5x4jlQMGG99arSxsyPrS9LwINOf0L/ox7JniBwWN6O57NbVfA6xudwaCsX2?=
 =?us-ascii?Q?LAgxRT53wdsJbRRBCMgRRD4vK+bsQM+kXjFXAitDeTnWQlxtgynorHS80+PS?=
 =?us-ascii?Q?AnytzmCPYzPYxqretSuXLxb1tMInV96cfLzCWEBK6c5PrUnBXOi1zm6JpqFb?=
 =?us-ascii?Q?CnWtNfINkXF5961JKOYiLYgLpW5Hh37SbwdpMWh9Pag/J3hSREuJnfoZ8+H+?=
 =?us-ascii?Q?nCJyOHp59w+xaqF7qQ8XYZjh1Hnb2hWLZiLa9sS9Y2TQl2Berj4DID488aZW?=
 =?us-ascii?Q?VWUw+8M03ZaQf5bKcOypmn7YvXl0CCMh/Upooyz/tX9NbEm754DMm5xkUyb4?=
 =?us-ascii?Q?BWl4v35EkkfP1ndfnfWINlEwXlq1XVA5OSzMyPia9REuwnkre0HNF7AqDOhn?=
 =?us-ascii?Q?4nK5Jq4cHHNTiL7pxU6+RSLDvQimCPN30suDgxfnf2NWo2VDy5UDFK43dYNB?=
 =?us-ascii?Q?mZgac3GY9ckomw6/7ykj0y6XaRAF8F0h61wIh2tZm96zeKHSbyUvw7jyDvHF?=
 =?us-ascii?Q?01AdJVMRyfN6mkpFI/iH4kLlpSkYL/dAgPsj+3UnUn7Q39nLxy6GM6NFxi1W?=
 =?us-ascii?Q?uHeJycLkWW4L7l5m88GGRHM=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: asem.it
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR22MB3789.namprd22.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 53815148-9959-4b66-a21b-08dc4424fdeb
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Mar 2024 12:48:04.9103
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 855b093e-7340-45c7-9f0c-96150415893e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JdrgEE4rTS5rv/+lvNJkfI3mtmhR1RKIcOCZpXpF6Wwk4zgkkDuOZ3qE+qYRPSL+PQ+QNiVZapUI88qZl23++mE6ZKxRO85BBIFlm9s611VUHM4PiGkbQy0cNOlajy/Z
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR22MB3740

Hi Thomas,

...

>  drivers/video/backlight/mp3309c.c             |  1 -

...

> diff --git a/drivers/video/backlight/mp3309c.c
> b/drivers/video/backlight/mp3309c.c
> index 34d71259fac1d..059f4ddbbc842 100644
> --- a/drivers/video/backlight/mp3309c.c
> +++ b/drivers/video/backlight/mp3309c.c
> @@ -378,7 +378,6 @@ static int mp3309c_probe(struct i2c_client *client)
>         props.scale =3D BACKLIGHT_SCALE_LINEAR;
>         props.type =3D BACKLIGHT_RAW;
>         props.power =3D FB_BLANK_UNBLANK;
> -       props.fb_blank =3D FB_BLANK_UNBLANK;
>         chip->bl =3D devm_backlight_device_register(chip->dev, "mp3309c",
>                                                   chip->dev, chip,
>                                                   &mp3309c_bl_ops, &props=
);=20

...

I've just tested your change with my board with the mp3309c backlight and a=
ll is ok.
Thanks and best regards
Flavio

Tested-by: Flavio Suligoi <f.suligoi@asem.it>
