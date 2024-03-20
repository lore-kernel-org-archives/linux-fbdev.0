Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2062.outbound.protection.outlook.com [40.107.93.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBA7A39850
	for <linux-fbdev@vger.kernel.org>; Wed, 20 Mar 2024 08:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710924374; cv=fail; b=snkjsO1YNr9JPmtBI3i9vUBuu0lIvuKTVEP3zBucp9UpdzItfk44Qnvmyb4Y8AeZdALNiF7d+yrA91uSWgjiv7cYGlVUfy212sE6DcWc3Zp9RdmMGUy4zJ1SpduJ4FLedR3ekbZpXrSfi+KWpNJ+18IGhw31E4QKE/oa6R+miGk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710924374; c=relaxed/simple;
	bh=MlTL46Lub++UYBcQVJQ96wVxnJGxb3eT+W2dc5AUj7E=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=k8AB0nWG01DCq6OC8vdj9Wp5xxEUrrITtqcUjyQgIkQl2g4nX6TmTjlY8V7x8KIDb4Qb7IC5teV/G+brEXjWIqkwyGqGZbgAIUt0aZUXLGVlNa0Uyh0JnGZ6g4EgpaH9p50rUvAEcuiNZsFdYrb3rb2CtSDn+Vh3TCRLtHWGPyM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asem.it; spf=pass smtp.mailfrom=asem.it; dkim=pass (2048-bit key) header.d=asem.it header.i=@asem.it header.b=AEMh41pQ; arc=fail smtp.client-ip=40.107.93.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asem.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=asem.it
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=asem.it header.i=@asem.it header.b="AEMh41pQ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W1UsZ8g69N/pFppqxNhq67KMlQ/dHXNbgpkJvB5JMVvkL9oVVQReKtifFsNa4Gosc78hs46OiZXE7U2Lyh3X9woqMdULslAFRhaPsSsWLVycJ6NHsEeLIMxqNcgkY7qeSAgtrgE6lc5OS2DlDl2I2AJ9ohFJxuLs9iF900moNL8Q3gIrjZgYfyZ8nmMhf3HHasiqr5ZL/SAMUIF4V3VnDE8/70Vp++xUIVwunrPJxMu7p4VYk2U0y+EmdLwuy50uKE0aRuFiX8v3teLA8qoVDGZ0doRgcbLDI5J2n5xjjJjKB/uZBtcefGHF3Dn0nmPvTHAgh7XfhMrcsOtd2qc4Bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MlTL46Lub++UYBcQVJQ96wVxnJGxb3eT+W2dc5AUj7E=;
 b=jVMl3uoM+YMrfGZg2m5lRvYNOzAcr2vY8uL6+2LE990UIskv/y6hgUMLDgTf8mz/yuu7bBbTlWq9oewBDKS11fUosREcehbRD/6E+1E7qbgoKbuNiR5aOVVaW0rI6oe+Umj04OhXZx9GhDZSwXMmZaE/mtH4Qy6CQUemrUfDWe+J0qUw8PdLoVB4mMUhs8kkdCove0JPvdOrABD7dB75uylc8LacEtjY7zj1yiz+XcNau7dFkGhNNV/u9I3GErGxeje3u5Jxi/ou3xIHB5dg1KV/k63CHZvZx3gsL09QwKOe1yZxx+lHOS6/MwcNm3AhjQGI0XcXx7ucPBcvmpVpVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=asem.it; dmarc=pass action=none header.from=asem.it; dkim=pass
 header.d=asem.it; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=asem.it; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MlTL46Lub++UYBcQVJQ96wVxnJGxb3eT+W2dc5AUj7E=;
 b=AEMh41pQIoZIpU1hjMuxh6Qp7NHp0jBr/vYIUa3qFAaJA/Zk0oz/bp0FJBX1bs+yuAGSvi7JoLMULXKRfNcSi0wu4uWESw8DnEttrDdmAG8Copku9S9ot2sPaACO1jD8unUHiIMS8L5CVnFTUYT5dLAXHnWOVB0KhUFY20VballZ5eXjB2yBVTIOhVHRBHI2IeZZsL4xttpZFbRq7WlvcyjUoj2uCESZdE8RGXZgWcGiPAKZtFSchjjY5l5PyX+kDtEUAgII3gplP9oxja27Bte6XMovhs9Hf8QKVLcTID3NuLVlu7MjtL3SkI9q3xchwqCeHFZrtpKRedLBChULSw==
Received: from PH0PR22MB3789.namprd22.prod.outlook.com (2603:10b6:510:29c::11)
 by PH7PR22MB3037.namprd22.prod.outlook.com (2603:10b6:510:133::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.30; Wed, 20 Mar
 2024 08:46:08 +0000
Received: from PH0PR22MB3789.namprd22.prod.outlook.com
 ([fe80::35ce:ff48:fa8b:d4a7]) by PH0PR22MB3789.namprd22.prod.outlook.com
 ([fe80::35ce:ff48:fa8b:d4a7%7]) with mapi id 15.20.7386.025; Wed, 20 Mar 2024
 08:46:08 +0000
From: FLAVIO SULIGOI <f.suligoi@asem.it>
To: 'Thomas Zimmermann' <tzimmermann@suse.de>, "lee@kernel.org"
	<lee@kernel.org>, "daniel.thompson@linaro.org" <daniel.thompson@linaro.org>,
	"jingoohan1@gmail.com" <jingoohan1@gmail.com>, "deller@gmx.de"
	<deller@gmx.de>, "andy@kernel.org" <andy@kernel.org>, "geert@linux-m68k.org"
	<geert@linux-m68k.org>, "dan.carpenter@linaro.org"
	<dan.carpenter@linaro.org>, "sam@ravnborg.org" <sam@ravnborg.org>
CC: "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
	"linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>,
	"linux-staging@lists.linux.dev" <linux-staging@lists.linux.dev>, Nicolas
 Ferre <nicolas.ferre@microchip.com>, Alexandre Belloni
	<alexandre.belloni@bootlin.com>, Claudiu Beznea <claudiu.beznea@tuxon.dev>
Subject: RE: [PATCH v2 6/6] backlight: Remove fb_blank from struct
 backlight_properties
Thread-Topic: [PATCH v2 6/6] backlight: Remove fb_blank from struct
 backlight_properties
Thread-Index: AQHaeqMNhOWwbc8AK0uuu/eEdiHVPQ==
Date: Wed, 20 Mar 2024 08:46:08 +0000
Message-ID:
 <PH0PR22MB37892E08DA11EDF48D956646F9332@PH0PR22MB3789.namprd22.prod.outlook.com>
References: <20240319093915.31778-1-tzimmermann@suse.de>
 <20240319093915.31778-7-tzimmermann@suse.de>
In-Reply-To: <20240319093915.31778-7-tzimmermann@suse.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=asem.it;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR22MB3789:EE_|PH7PR22MB3037:EE_
x-ms-office365-filtering-correlation-id: b8e674a0-92ea-4b7e-7c3a-08dc48ba2fac
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 Uia8SWZ6iwZHVn3IFvl4QcN5YSTzmVCL0kjbR4683tK5//UXt5g/7MWNbka9QbXIgquPyop/l6TSKJLc8Y6J8EmNaGQdr/lpp2jRxkBBWlxAUoiP2D25CKex2V7/g8b0Vi4DrGdqASrIMJWjBlVj3CONXqMY7WUh3u49EOfsXu50ORs9OcPgPD5EFIPKgMf80aul+IBdQ8xKLnPtFPE/ej8znkpXXB9Df6ACwyeeqOLPjvc49txIqN+4xGvLDPMg8yrC+lcbFxMCxIVG7wF4S5Rly5mtuAGvoc0r9LOMTu6S1emcBTrpRq1EBdnStb4kxARl8YnMnDWYNSESUJbNjUs0SQ2HSaResp85ZTRrwFc4kw1Qn3IFTxbRXFs1KxAuV8rkdnqeyzcED++nei54oTB2jucC0c9Wxy/inxr+0de04Wli909Pom83rPS0y4ypiNIDZfhNZdGAlTe44AaeFWt7UFFqzPhO4YZVdIqhUgz0yB6iZIOo80ie+VZY84ZTlJT57YqjTi4L0lXtmftuhxSAlYxUijc+S9rJVMzFu9MvLIh0cwHgwkm4MW1YMtBChSd+kYMVu7CdRI+2nxoIjeroVABKwIFBx0bjEZ0UH8284Q7UkhVinatg2M5afz3HKFWEjf6QRhg+0JSe+gM0Bund2eqUzzolJQtqqNtIrVaXrV33x0d6wuWmyJQ5TBuo2TIrmbU/OBiVa9IgbyEW4w==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR22MB3789.namprd22.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015)(7416005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?QGF0V1zuQUghERBvaiP2IGcQbE3n5YqYQWywHwno2yzWeo7M5bxVtog1u8ci?=
 =?us-ascii?Q?PddTduzaqPpiGPtvo6b2++dDx6IRxRnT1QXDtyetvn0NQDheLbV/T8AuM/bt?=
 =?us-ascii?Q?BT4e+FB38VjGybyUYmkws8k8j8Q0yDJ7eUxPyaCGo1C8JjrBs2SIIMLESjPe?=
 =?us-ascii?Q?f0cIu82Vn29boJPRtN2u7UACWEvtNifAImf6kAKuwx5CTVSZZCEGw3cysejD?=
 =?us-ascii?Q?sXzrFQX53diGgt/Sn+eIK2OlFd0z9fnP8cim+fpuFeGyD+jUe05NVFLchcpN?=
 =?us-ascii?Q?x0GljW20U38xHx7CJ+qjTjLCdhXLBTemz+11zOU1/MlGFhsYFH16rc0JTZc8?=
 =?us-ascii?Q?noxkrrqNGQgqKhBDtoBPSi5VD/EFcTbSmRCWf81Yjv9f+cC5asqLRPqtQhCt?=
 =?us-ascii?Q?ltM1m7gAtSBSCDyHjr6RZEnHi30n5JcSJxCiTHvd8sB3dx0dP8Yc5FVygjT9?=
 =?us-ascii?Q?uAC4VlskFnDG26SC9fX614/zG1N9zG6pHtrm0gPrweJAGCMKqLRULwwPmfZC?=
 =?us-ascii?Q?Zw/pPQq8al4SDibHVoKZRqd+Z9+LxaXUpu6RZZqBb7jVICqnqkCNojnWVzp/?=
 =?us-ascii?Q?mIKi1KGvp0GOZGRwcVgZ07r3Ce0Tltxr0KZVvhp3BJdPJv0qgA3O6ok+Du2u?=
 =?us-ascii?Q?L7STibGQTTEbxwgSzwXyrhaq91gQQitUPRFc3s7REc19udaUPS33frkjMSqR?=
 =?us-ascii?Q?nYQIGQ3D3mAarz16K0z/muq3ProWG9l2z8C1uvTLMkhwIZbRdy2i1exri7C7?=
 =?us-ascii?Q?YUMzo2QvVKuPoGSMY2FeK6jyL9RcPgAEQhLgC011bnoCNWa1OQn2qkT436/s?=
 =?us-ascii?Q?sV0HawKVw7jwtSjiYqOZekOho+rqjhHn1mSxNZJAVUO4CBn8KXf0D5yWLqdn?=
 =?us-ascii?Q?jz5vPQp/JnqnHBwI4KLr7cFDlTq3vHRFk9u7ZK+ckhIRrP+exv25K7LYP7E4?=
 =?us-ascii?Q?riQKa94bq0lhPebcG18akvKZ4yq9vVXphhek8RNwUPNQFA9R3Nwto9uq+L8O?=
 =?us-ascii?Q?V0Httyf2FDK9K2TeKM6Q8uWhYuxkoeU5FEpNrmarU2ekTMdXschuxFm9+djx?=
 =?us-ascii?Q?eL8gOl+Y0dfcxKDaJdUgkY+UlJzN5CTZff9eCaq4XzGMaPRA+sWM8syoA7Ur?=
 =?us-ascii?Q?g5EzH22bgifJfjk21i8E4CZ7w9ef5+7IjhfRzLhC9ug3AA5atuvekiSI15CW?=
 =?us-ascii?Q?miTmk3n1NHcYD0cRY5mWx6Nf/5Xl2mtVrkiehCLKcomU8eCuLHzVbznMl/ga?=
 =?us-ascii?Q?MwCEF02QZqeKPXJsGHK8U/nTMqW4k3X3NoLE1+hkBxzenCiNmQ4pkmf4VV2O?=
 =?us-ascii?Q?PUc+oQwtz/GZ7LvsIrXylSz7YMN8a2zvv+v/4CD74Tfkmj/URecwao5ZTzID?=
 =?us-ascii?Q?iN2KIvjol7OwfCMgqtY1/Q+9fgBURJl4GaZ9F/lQDUe+6p6uMlbz/opTZy07?=
 =?us-ascii?Q?0Za3HKlPrBOyeKXEh6eRA3jJyYqEVOeuqrp8trEA57wzXgbD82QA7SlvCkIr?=
 =?us-ascii?Q?evrkzd+AFZ2ggiUDvp9APQIQUEr9n0WdmdVrrSwRMactZt50gLfWFsKoO34C?=
 =?us-ascii?Q?sJnef3kI2SOhdbNYnRd3ThtLujiQvvzCdD9Mi5Uu/dkfQhcZPnUUXm1+V8Xz?=
 =?us-ascii?Q?V+aO3VVR+2tt0w2ZLS5y/A0=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: b8e674a0-92ea-4b7e-7c3a-08dc48ba2fac
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Mar 2024 08:46:08.0556
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 855b093e-7340-45c7-9f0c-96150415893e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gxlYx/GBwTPOhFv6WLlC4pVqrTf5vQtzjklq6tR5vSX2p89kqn9LQuAr/R8SA7N8vH1qP7wieJ6WSPOADTbYyzovzczWsbgCmpVsNUzwYbo17cydRbCSsQLwZzg+ZIuE
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR22MB3037

Hi Thomas,

...
> Remove the field fb_blank from struct backlight_properties and remove all
> code that still sets or reads it. Backlight blank status is now tracked e=
xclusively
> in struct backlight_properties.state.
>=20
> The core backlight code keeps the fb_blank and state fields in sync, but =
doesn't
> do anything else with fb_blank. Several drivers initialize fb_blank to
> FB_BLANK_UNBLANK to enable the backlight. This is already the default for
> the state field. So we can delete the fb_blank code from core and drivers=
 and
> rely on the state field.
>=20
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> Cc: Flavio Suligoi <f.suligoi@asem.it>
> Cc: Nicolas Ferre <nicolas.ferre@microchip.com>
> Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>
> Cc: Claudiu Beznea <claudiu.beznea@tuxon.dev>
> Tested-by: Flavio Suligoi <f.suligoi@asem.it>
> Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>
> Reviewed-by: Dan Carpenter <dan.carpenter@linaro.org>
...

Can you explain what are the differences between the version 1 and version =
2 of the patch?
Thanks,
Flavio
