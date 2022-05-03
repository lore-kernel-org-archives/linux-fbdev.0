Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6468CC433EF
	for <linux-fbdev@archiver.kernel.org>; Tue,  3 May 2022 01:09:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229587AbiECBMf (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Mon, 2 May 2022 21:12:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229657AbiECBMc (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>); Mon, 2 May 2022 21:12:32 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6C74403F4
        for <linux-fbdev@vger.kernel.org>; Mon,  2 May 2022 18:08:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651540133; x=1683076133;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=MQ8iktvyYen4K3CSGKeM5lewRnF/c0Vh2S3m72HzkpY=;
  b=OevfTHdKKhEykjFdrgInCjANYNiSLO1rsYz9zQSfzDe28mMC+6RltYuz
   TMOlyy/9PE4katkNdGcq4SSmNGr9VYKP9rEOdvp/pzwk7Exz7T0ptIYOh
   Hj3+7bZhVIuglOdVmvBDLkODNqJYac7tIOoGHYzbJgiTV+aU/A+4wDdfp
   dyZ9gkVRXkblx07GmKw6lV4+pTVMPtKkHqct92rCCmkozd/rSEA5XX3tp
   RBEQixIZ8vsaL2Sn3d7A+F/tNHe1JHLsE8cbgzgLn6XFXzS7V2KtX3Rc1
   BNCJ+lxkEN/+14LAYbp6xBYKsLrp1DTVR6tf2wc+9wEyJ4U4TfsnjYMdm
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10335"; a="249347374"
X-IronPort-AV: E=Sophos;i="5.91,193,1647327600"; 
   d="scan'208";a="249347374"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 May 2022 17:38:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,193,1647327600"; 
   d="scan'208";a="598870282"
Received: from orsmsx606.amr.corp.intel.com ([10.22.229.19])
  by orsmga001.jf.intel.com with ESMTP; 02 May 2022 17:38:41 -0700
Received: from orsmsx605.amr.corp.intel.com (10.22.229.18) by
 ORSMSX606.amr.corp.intel.com (10.22.229.19) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Mon, 2 May 2022 17:38:41 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx605.amr.corp.intel.com (10.22.229.18) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Mon, 2 May 2022 17:38:41 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.101)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Mon, 2 May 2022 17:38:41 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DByFTJWPZgKgLCOzeoP/jCnPvfovf9TEMpn7AqdcMIYqQ2JiZMvSCKLWgAWmD3i4XI4v0+jwqg/0PV/t1wo790wfHqwQ05T0AKZg9hfRzGNZlL+Myy2Cluzp8+I1OrnBC9HrTbrSnyAwbrCaNrw6KL5qc3e3NHR2PliXmi9VPld2vSNH0C4NQYwaLpHclSOXDD7YDis5w7W+ZnpmumTZkqGdBJUy3EBrPJ3flRcJ4U1VWg3EZu4tucuHp3eo7Itbd1GMQBwSzerImsZS6EInyyT3ol45g41mFXxIZ+hGoxU3GnyI/yeWm37zpERo5m8DBsYo7Uc25VRtfuvT+HdwHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MQ8iktvyYen4K3CSGKeM5lewRnF/c0Vh2S3m72HzkpY=;
 b=HHZItaHqJjXTCvTccuV8o7tt/5/MmXVEPcV4jK+qiDjef5c6Bde860slmzapDH6dYnP9yirkH99OptBAAYuMdpwJxILNgKNBzqcBk3s7JrYXxLiXGMnbZW58QFX5GfrLsfT44mYz+HejgLTJ+K2w4oAnuejkVzDXWKvN/f+KP6KuHql+MEUhJUIdlpQPejtcEygJHCFJUdOj2IiQrtkiGugefwTYx38Za+k1QJr13EOZWqEMuZkU1HU6Eu+8vx0PR8cLdc1aSZ0DNix3IEWgA+PCtR3qMZliC4qqyPGIP4YpmBoURpf2mvOKjRQYiPnNyK47U3lcf3QnsN4adLQ6oQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5370.namprd11.prod.outlook.com (2603:10b6:408:11b::8)
 by DM5PR1101MB2186.namprd11.prod.outlook.com (2603:10b6:4:52::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.14; Tue, 3 May
 2022 00:38:39 +0000
Received: from BN9PR11MB5370.namprd11.prod.outlook.com
 ([fe80::593f:5bc9:6120:b40e]) by BN9PR11MB5370.namprd11.prod.outlook.com
 ([fe80::593f:5bc9:6120:b40e%7]) with mapi id 15.20.5206.013; Tue, 3 May 2022
 00:38:39 +0000
From:   "Chang, Junxiao" <junxiao.chang@intel.com>
To:     Thomas Zimmermann <tzimmermann@suse.de>,
        "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>
CC:     "lethal@linux-sh.org" <lethal@linux-sh.org>,
        "patchwork-bot@kernel.org" <patchwork-bot@kernel.org>,
        "deller@gmx.de" <deller@gmx.de>, "Li, Lili" <lili.li@intel.com>
Subject: RE: [PATCH] video: fbdev: don't remove firmware fb device if it is
 busy
Thread-Topic: [PATCH] video: fbdev: don't remove firmware fb device if it is
 busy
Thread-Index: AQHYXD5CaeUMCFvvAEmVWevDAY4rPK0LMruAgAEaEyA=
Date:   Tue, 3 May 2022 00:38:39 +0000
Message-ID: <BN9PR11MB53709B93930F49194C0E5757ECC09@BN9PR11MB5370.namprd11.prod.outlook.com>
References: <20220430025749.2320824-1-junxiao.chang@intel.com>
 <ab099144-2db2-caae-7a59-94211111a6cf@suse.de>
In-Reply-To: <ab099144-2db2-caae-7a59-94211111a6cf@suse.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-reaction: no-action
dlp-version: 11.6.401.20
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 529aa680-7001-48cd-4586-08da2c9d442a
x-ms-traffictypediagnostic: DM5PR1101MB2186:EE_
x-microsoft-antispam-prvs: <DM5PR1101MB2186DC7DE0834CBBD099621FECC09@DM5PR1101MB2186.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: gRKsO/s9ddTcTvVn69z8IOZhKJxE9M5FwFo3P98aFLjXYBs0O48AFbpwi2PEeuB4v9yiErxAP747s6sG9ZAUe6YvYxBrs664np0KNDjZEImI0FG6/94ooDzXpJuLaSDZLM+bzxCGzC2sc9+h2i/aW5p04ung/dpZU3rs9v0IRCRE45XASyis5ZB76mEWYevgxdsQPPZd0wsLawdB7Oo8wkmlApj31tO03zBlHWAEjGmeA52zEBh/u2OlttH8C0B4ZaXC+Mbhlp1WFLI4Syn9k7m7/P2N3JG77HQi1WsRDEGpzQggf5IVPVBpPTnm3mBTzI3le+H5cD9Bi/Y+gu9mNbfNv59xksm9siXQR54NrAs6ZAE1hq2Oy4rXu+CsNoCta+aS+ObgcR7cv1qHLbE+ra6YeciTXNC7wkhPeaChWUl1SPoXd2XsnYEtv65t3agB1XMiCS6aCuoDgSd2V7t7P2aWVBLtJduQAPBtIi1iZVpj/Hwbc9AvcToQGVBae/46q31LdbKHExdQIh0BXAvlXsVTauXYdB4f2ljmsAySrjf2B7S/6mYlsZmgGa2aElnRCaieuA80tTDtZPCyeNsAkdOeO7o6bmr8oeRKvopskphzfYrPAdpgUgZpdPRtMW9RMn7EXolw7IfUZTEsrftYo9iaH7iQE6O94LcsXegx5Vb4eBcSld3V3PCETPCdXTcOztW5U0jD5OxuVH3HiCOQqw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5370.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(66476007)(64756008)(66446008)(66556008)(66946007)(316002)(8676002)(76116006)(110136005)(54906003)(4326008)(508600001)(122000001)(86362001)(38070700005)(33656002)(38100700002)(6506007)(7696005)(186003)(53546011)(71200400001)(9686003)(26005)(55016003)(8936002)(52536014)(5660300002)(66574015)(107886003)(2906002)(83380400001)(82960400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VjhpMU9adVo1MGJCWkFBcHJ4TTNCRlMvVW80dDJnK21rUUc2M1pGVm8xWlF6?=
 =?utf-8?B?UUZ5YnZ5Y0hhbURMQjBXL2llUXZnMGhvbWpIQUF2c2o0TStwWm5FT0UzVHRr?=
 =?utf-8?B?ZWFSWGF3anArdFN4Zkc2R25McWd4Z1phd0ovNG1OcE9neTZvY0lYWWZOZlR4?=
 =?utf-8?B?UXFHUit2RXJvQldOdHN5ZXFGa1NtZW5XRUN5U041UXR3d0ZVa1gwckx3R1dL?=
 =?utf-8?B?aEN6QjhTMHExTzZhVk9uQkd2NUFuR0FlZ1hLK0YyUDBmbnlLZmxVNmVqWE9J?=
 =?utf-8?B?b2NDS1NVNFh1VEg3Z1B2bllJUEZvSFg3V2ZiVkI3WFRHdTc3ZGlKV2ZZeVZF?=
 =?utf-8?B?M251bzdaWUMvRFJYOExFUjJRYWFJYVlKVTlobTk1TUl1d09ZZjVCSnE0cDlw?=
 =?utf-8?B?WWlJMjZrZGpFRGRjdkJRYU5wdFRsRmhOd0lkRVp6cFRmeGE3UHBtU1FZQ2p1?=
 =?utf-8?B?K01RVUdvQVNqcElMWmRYZkJxY250b0t5a244aDV3Tk9UT25RcERLOFZmTjhj?=
 =?utf-8?B?MkIxelMxQUUxNndMSXJDYTdzRDRqei9YUnNuSzVFcDNYcFBzcEZHQmpFQ0dQ?=
 =?utf-8?B?K0EvZUtDNncwb2pFTUpKSTZMQlF5bUd6ei9iWFFCa1JONkRwVDJoY3RjS0t6?=
 =?utf-8?B?VFhwMjFnWkZGTHZMbTdGdEl4cU5vTzdxalNwSjVBR1I1ZHdpcWZOMFVnc3hm?=
 =?utf-8?B?NzJpK2xDY0UxZFBnTi80ZmZHNmFDaUQwZkRWVDVJeW51RWlFVTYxY0dDSDBS?=
 =?utf-8?B?MTk0ZHA2RDFLS2YxcGZqK2VPMnYvVHc2cnUwNUtydWhRd0xuYmJCQWlsSENs?=
 =?utf-8?B?Qk1GaGFpQ0t4UzdVZHU0NnJoK0oyK0lTNFlOSXR5dk9hUG1DcXhSMXlhUmF3?=
 =?utf-8?B?SksvRU5IRUFONG1Jb1V1Y1BtY3kvOWMxK1VpOExDZUVUM000ZUNkdEIzSGJB?=
 =?utf-8?B?WVlocHB2TVN6UGJPK2Q3ZU1SMVZFais5SENmUWxnNWJCQVRvMDZSVjdSTk4w?=
 =?utf-8?B?OHZER2l3M29vZXZhNGZ5Nm9XV21EN0FvbnVCUUxNRDZvTkF3R2R2MlVOV3NF?=
 =?utf-8?B?cnQwMnhpQVcyamlZTEc4ZStUOFk4VVFPaEpraG5TOVRtSHBGaFVLYzVCYXNi?=
 =?utf-8?B?VFY2bkZrMEVQb0xITHBZRVBJUXFQZjgreTlXWVk1TTZIRjYrRXBOb1JSclFJ?=
 =?utf-8?B?by9JOW8vTmJyeCtZRTRCeG1DZ3p1bUJDUThoT3R4UG5jU2hlSDZROTd2OXNs?=
 =?utf-8?B?TEFlRGZENzRlTVhmUkVoeFRObkxGSVZHdWNhbC9GN0FJWVYrZlgrcSs1SVoz?=
 =?utf-8?B?QXB5Y2U4WWVjamRqa3BsSjNqaUZzeEk3enlLcXNwQkVoRjBzRzRYaENzNDdu?=
 =?utf-8?B?MUJ0WEhjSFk4MWY2YmdkUVpGeS91K0Q4K0xtZ0RKelZvQjVsSlhpYzZud3lX?=
 =?utf-8?B?VEY5RVd2S0RxWkgwSFgyZzJuWlMzaWp1QWkzSXZUTmREWit6RG5DdDJPNjVJ?=
 =?utf-8?B?Wk9scFprNnRqZWIyQjN6N0YzM216bzYyZ0ozMnFsYmpTWEVnQUdqcm1NQ2tL?=
 =?utf-8?B?RkZkc3lPZkVoVHJOeEpldkR6blJxQURVbldmVUdKckdLYlN5bFNwOVV0OU1G?=
 =?utf-8?B?ZWh2eGY5eUhZdmZsREgrODhxUlgwbFM5Y2JOSGtvS3FCMXQ0clJDVTJjci9W?=
 =?utf-8?B?Ujd5WEp6U0JBRWJrTC9JdSs1VDFpYzloNGJLYkx2NFRGOElxT2RQek9mVVlU?=
 =?utf-8?B?UEtxdGVKczBEbHZ1eDJtN3RxQ3JKdnFIMy8zYktjd3pBUkk4L2FQdDZXT1ZX?=
 =?utf-8?B?NHJZdy94bFdhRm5YYmlQanU0STJ2eFZvWW1idHN2bWhta1A2Y1lud3hON0J5?=
 =?utf-8?B?WUhsaXFEbXF2ZCszbklGaEdobzZBaGRVYnUwYjNaRFlNL0szeGN3cGRFK0xk?=
 =?utf-8?B?QjE4SHpNcWVaYzg2VzNIS3VhVkQyWXhnc1MwbWh3NHJqQmhiMVpnUUFKekRT?=
 =?utf-8?B?OXI5MUZSamtic0F5UHoxbkp4VmdZeUsxT2Q5VVFGcWFEbTVEeUVaL2hBNXpF?=
 =?utf-8?B?N2puMXZ0NHhBaVpTUHVPYndvL2NNMXUyL3k1TmNLQzFyZERxTjh0c2FieHF3?=
 =?utf-8?B?L3RhcHV1QnpjeUZ3RWk3OWhoTFZyd3VKbEI5cVlJR0gwdkZXamNVekZ0NUZJ?=
 =?utf-8?B?THVhSTR6amFEdytDZTZVb2hGUHZTcWNGVG1VMkt4WitUbWViMit2VVVUbFFz?=
 =?utf-8?B?TURPbUNaMGQ4Nnordk5GSEZNcXRsQ3BCWnFOdXF6YUhFazBjOWRSLzR5dDhv?=
 =?utf-8?B?TjRZcnhNZlhaQUtTUDllV2xTWm84aWg4SHg0THp6TzdMSWFjYzQwQT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5370.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 529aa680-7001-48cd-4586-08da2c9d442a
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 May 2022 00:38:39.0986
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: asKukGteggb32RBNPwW86zLTRDK2qdZhaYabBpzmQM59fqgbgjf+YqYbvESxdiq2EVhSwvsZ9FL7FQsccX1EfA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1101MB2186
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

SGkgVGhvbWFzLA0KDQpXZSByZXByb2R1Y2VkIHRoaXMgaXNzdWUgd2l0aCBZb2N0byBpbWFnZSAr
IDUuMTgtcmMzIGtlcm5lbC4NCklmIHlvdSBjb3VsZCB0cnkgWW9jdG8gaW1hZ2UgYW5kIGVuYWJs
ZSBwc3BsYXNoLCB0aGUgcHJvYmxlbSBjb3VsZCBiZSByZXByb2R1Y2VkIGFsbW9zdCBldmVyeSB0
aW1lIGlmIHBzcGxhc2ggaXMgbGF1bmNoZWQgYmVmb3JlIEludGVsIGk5MTUgcmVnaXN0ZXJzIDJu
ZCBmcmFtZWJ1ZmZlci4NCg0KRHVyaW5nIFlvY3RvIGJvb3RpbmcgdXAsIGl0IGxhdW5jaGVzIHBz
cGxhc2ggd2hpY2ggb3BlbnMgRUZJIGZpcm13YXJlIGZyYW1lYnVmZmVyIGFuZCBwbGF5cyBhbmlt
YXRpb24uIFdoZW4gaXQgZXhpdHMsIGZiX3JlbGVhc2UgaW4ga2VybmVsIG1pZ2h0IGFjY2VzcyBt
ZW1vcnkgd2hpY2ggaGFzIGJlZW4gcmVsZWFzZWQuDQoNCk92ZXJhbGwgcHJvY2VzcyBsb29rcyBs
aWtlOg0KMS4gRUZJIHJlZ2lzdGVycyBmcmFtZWJ1ZmZlciBpbiBlZmlmYl9wcm9iZSwgZnJhbWVi
dWZmZXJfYWxsb2MgaXMgY2FsbGVkIHRvIGFsbG9jYXRlICJzdHJ1Y3QgZmJfaW5mbyIgbWVtb3J5
Ow0KMi4gSW4gdXNlcnNwYWNlLCBwc3BsYXNoIGlzIHN0YXJ0ZWQgdG8gcGxheSBib290IGFuaW1h
dGlvbiwgaXQgb3BlbnMgZnJhbWVidWZmZXIgZHJpdmVyLiBJbiBmYl9vcGVuIGZ1bmN0aW9uLCBp
dCBzYXZlcyBmYl9pbmZvIG1lbW9yeSB0byBmaWxlLT5wcml2YXRlX2RhdGE7DQozLiBXaGVuIElu
dGVsIGk5MTUgZHJpdmVyIGlzIHByb2JlZCwgaXQgcmVnaXN0ZXJzIDJuZCBmcmFtZWJ1ZmZlciwg
YW5kIHdpbGwgcmVtb3ZlIGNvbmZsaWN0aW5nIGZyYW1lYnVmZmVyOw0KNC4gSW4gZG9fcmVtb3Zl
X2NvbmZsaWN0aW5nX2ZyYW1lYnVmZmVycywgaXQgY2FsbHMgInBsYXRmb3JtX2RldmljZV91bnJl
Z2lzdGVyIiB0byByZW1vdmUgRUZJIHBsYXRmb3JtIGZyYW1lYnVmZmVyIGRldmljZTsNCjUuIElu
IEVGSSBmcmFtZWJ1ZmZlcidzIGVmaWZiX3JlbW92ZSBmdW5jdGlvbiwgaXQgY2FsbHMgZnJhbWVi
dWZmZXJfcmVsZWFzZSB0byByZWxlYXNlICJzdHJ1Y3QgZmJfaW5mbyIgbWVtb3J5IHdoaWNoIGlz
IHN0aWxsIHVzZSBhbmQgc3RvcmVkIGluIGZpbGUtPnByaXZhdGVfZGF0YTsNCjYuIFdoZW4gcHNw
bGFzaCB1c2VyIHNwYWNlIGFwcGxpY2F0aW9uIGV4aXRzLCBpdCBjYWxscyBmYl9yZWxlYXNlIGZ1
bmN0aW9uLCBhbmQgYWNjZXNzZXMgdG8gZmJfaW5mbyBtZW1vcnksIGJ1dCBpdCBoYXMgYmVlbiBy
ZWxlYXNlZCBpbiBzdGVwIDUuIEtlcm5lbCBwYW5pYyBoYXBwZW5zLg0KDQpPdXIgcGF0Y2ggaXMg
dG8gY2hlY2sgd2hldGhlciBFRkkgZnJhbWVidWZmZXIgaXMgb3BlbmVkIGF0IHRoYXQgdGltZS4g
SWYgaXQgaXMgZnJlZShyZWdpc3RlcmVkX2ZiW2ldLT5jb3VudCA9PSAxKSwgZ28gYWhlYWQgdG8g
cmVtb3ZlIEVGSSBwbGF0Zm9ybSBkZXZpY2UuIE9yIGVsc2UsIGp1c3QgdW5yZWdpc3RlciBmcmFt
ZWJ1ZmZlciB0byBhdm9pZCBrZXJuZWwgcGFuaWMuIA0KDQpUaGFua3MsDQpKdW54aWFvIA0KDQot
LS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KRnJvbTogVGhvbWFzIFppbW1lcm1hbm4gPHR6aW1t
ZXJtYW5uQHN1c2UuZGU+IA0KU2VudDogTW9uZGF5LCBNYXkgMiwgMjAyMiAzOjI0IFBNDQpUbzog
Q2hhbmcsIEp1bnhpYW8gPGp1bnhpYW8uY2hhbmdAaW50ZWwuY29tPjsgbGludXgtZmJkZXZAdmdl
ci5rZXJuZWwub3JnDQpDYzogbGV0aGFsQGxpbnV4LXNoLm9yZzsgcGF0Y2h3b3JrLWJvdEBrZXJu
ZWwub3JnOyBkZWxsZXJAZ214LmRlOyBMaSwgTGlsaSA8bGlsaS5saUBpbnRlbC5jb20+DQpTdWJq
ZWN0OiBSZTogW1BBVENIXSB2aWRlbzogZmJkZXY6IGRvbid0IHJlbW92ZSBmaXJtd2FyZSBmYiBk
ZXZpY2UgaWYgaXQgaXMgYnVzeQ0KDQpIaQ0KDQpBbSAzMC4wNC4yMiB1bSAwNDo1NyBzY2hyaWVi
IEp1bnhpYW8gQ2hhbmc6DQo+IFdoZW4gZmlybXdhcmUgZnJhbWVidWZmZXIgaXMgaW4gdXNlLCBk
b24ndCByZW1vdmUgaXRzIHBsYXRmb3JtIGRldmljZS4gDQo+IE9yIGVsc2UgaXRzIGZiX2luZm8g
YnVmZmVyIGlzIHJlbGVhc2VkIGJ5IHBsYXRmb3JtIHJlbW92ZSBob29rIHdoaWxlIA0KPiBkZXZp
Y2UgaXMgc3RpbGwgb3BlbmVkLiBUaGlzIGludHJvZHVjZXMgdXNlIGFmdGVyIGZyZWUgaXNzdWUu
DQoNCldoZW4gZXhhY3RseSBkb2VzIHRoaXMgaGFwcGVuPyBEbyB5b3UgaGF2ZSBhIHJlbGlhYmxl
IHdheSBvZiByZXByb2R1Y2luZyBpdD8NCg0KQmVzdCByZWdhcmRzDQpUaG9tYXMNCg0KPiANCj4g
QSBrZXJuZWwgcGFuaWMgZXhhbXBsZToNCj4gQ1BVOiAyIFBJRDogMzQyNSBDb21tOiBwc3BsYXNo
IFRhaW50ZWQ6IEcgICAgIFUgIFcgICAgIDUuMTguMC1yYzMNCj4gSGFyZHdhcmUgbmFtZTogSW50
ZWwgQ2xpZW50IFBsYXRmb3JtL0FEUC1TIEREUjUgVURJTU0gQ1JCDQo+IFJJUDogMDAxMDpuYXRp
dmVfcXVldWVkX3NwaW5fbG9ja19zbG93cGF0aCsweDFjNy8weDIxMA0KPiBSU1A6IDAwMTg6ZmZm
ZmIzYTBjMGMyZmRiMCBFRkxBR1M6IDAwMDEwMjA2DQo+IFJBWDogMDAyZGMwNzRmZjVjMDk4OCBS
Qlg6IGZmZmY5MmU5ODdhNWQ4MTggUkNYOiBmZmZmOTJlOTg5YmE5ZjQwDQo+IFJEWDogMDAwMDAw
MDAwMDAwMjA2NyBSU0k6IGZmZmZmZmZmODY0MzQ0ZjEgUkRJOiBmZmZmZmZmZjg2NDQxODNjDQo+
IFJCUDogZmZmZjkyZjEwZjRhYmQ0MCBSMDg6IDAwMDAwMDAwMDAwMDAwMDEgUjA5OiBmZmZmOTJl
OTg2ZGMyMTg4IC4uLg0KPiBDYWxsIFRyYWNlOg0KPiAgIDxUQVNLPg0KPiAgIF9yYXdfc3Bpbl9s
b2NrKzB4MmMvMHgzMA0KPiAgIF9fbXV0ZXhfbG9jay5jb25zdHByb3AuMCsweDE3NS8weDRmMA0K
PiAgID8gX3Jhd19zcGluX3VubG9jaysweDE1LzB4MzANCj4gICA/IGxpc3RfbHJ1X2FkZCsweDEy
NC8weDE2MA0KPiAgIGZiX3JlbGVhc2UrMHgxYi8weDYwDQo+ICAgX19mcHV0KzB4ODkvMHgyNDAN
Cj4gICB0YXNrX3dvcmtfcnVuKzB4NTkvMHg5MA0KPiAgIGRvX2V4aXQrMHgzNDMvMHhhZjANCj4g
ICBkb19ncm91cF9leGl0KzB4MmQvMHg5MA0KPiAgIF9feDY0X3N5c19leGl0X2dyb3VwKzB4MTQv
MHgyMA0KPiAgIGRvX3N5c2NhbGxfNjQrMHg0MC8weDkwDQo+ICAgZW50cnlfU1lTQ0FMTF82NF9h
ZnRlcl9od2ZyYW1lKzB4NDQvMHhhZQ0KPiANCj4gRml4ZXM6IDI3NTk5YWFjYmFlZiAoImZiZGV2
OiBIb3QtdW5wbHVnIGZpcm13YXJlIGZiIGRldmljZXMgb24gZm9yY2VkIA0KPiByZW1vdmFsIikN
Cj4gU2lnbmVkLW9mZi1ieTogSnVueGlhbyBDaGFuZyA8anVueGlhby5jaGFuZ0BpbnRlbC5jb20+
DQo+IFNpZ25lZC1vZmYtYnk6IExpbGkgTGkgPGxpbGkubGlAaW50ZWwuY29tPg0KPiAtLS0NCj4g
ICBkcml2ZXJzL3ZpZGVvL2ZiZGV2L2NvcmUvZmJtZW0uYyB8IDQgKysrLQ0KPiAgIDEgZmlsZSBj
aGFuZ2VkLCAzIGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkNCj4gDQo+IGRpZmYgLS1naXQg
YS9kcml2ZXJzL3ZpZGVvL2ZiZGV2L2NvcmUvZmJtZW0uYyANCj4gYi9kcml2ZXJzL3ZpZGVvL2Zi
ZGV2L2NvcmUvZmJtZW0uYw0KPiBpbmRleCBhNmJiMGU0MzgyMTYuLmZmOWI5ODMwYjM5OCAxMDA2
NDQNCj4gLS0tIGEvZHJpdmVycy92aWRlby9mYmRldi9jb3JlL2ZibWVtLmMNCj4gKysrIGIvZHJp
dmVycy92aWRlby9mYmRldi9jb3JlL2ZibWVtLmMNCj4gQEAgLTE1ODYsNyArMTU4Niw5IEBAIHN0
YXRpYyB2b2lkIGRvX3JlbW92ZV9jb25mbGljdGluZ19mcmFtZWJ1ZmZlcnMoc3RydWN0IGFwZXJ0
dXJlc19zdHJ1Y3QgKmEsDQo+ICAgCQkJCSAqIGZyYW1lYnVmZmVyIGFzIGJlZm9yZSB3aXRob3V0
IHdhcm5pbmcuDQo+ICAgCQkJCSAqLw0KPiAgIAkJCQlkb191bnJlZ2lzdGVyX2ZyYW1lYnVmZmVy
KHJlZ2lzdGVyZWRfZmJbaV0pOw0KPiAtCQkJfSBlbHNlIGlmIChkZXZfaXNfcGxhdGZvcm0oZGV2
aWNlKSkgew0KPiArCQkJfSBlbHNlIGlmIChkZXZfaXNfcGxhdGZvcm0oZGV2aWNlKSAmJg0KPiAr
CQkJCQlyZWZjb3VudF9yZWFkKCZyZWdpc3RlcmVkX2ZiW2ldLT5jb3VudCkgPT0gMSkgew0KPiAr
CQkJCS8qIFJlbW92ZSBwbGF0Zm9ybSBkZXZpY2UgaWYgaXQgaXMgbm90IGluIHVzZS4gKi8NCj4g
ICAJCQkJcmVnaXN0ZXJlZF9mYltpXS0+Zm9yY2VkX291dCA9IHRydWU7DQo+ICAgCQkJCXBsYXRm
b3JtX2RldmljZV91bnJlZ2lzdGVyKHRvX3BsYXRmb3JtX2RldmljZShkZXZpY2UpKTsNCj4gICAJ
CQl9IGVsc2Ugew0KDQotLQ0KVGhvbWFzIFppbW1lcm1hbm4NCkdyYXBoaWNzIERyaXZlciBEZXZl
bG9wZXINClNVU0UgU29mdHdhcmUgU29sdXRpb25zIEdlcm1hbnkgR21iSA0KTWF4ZmVsZHN0ci4g
NSwgOTA0MDkgTsO8cm5iZXJnLCBHZXJtYW55DQooSFJCIDM2ODA5LCBBRyBOw7xybmJlcmcpDQpH
ZXNjaMOkZnRzZsO8aHJlcjogSXZvIFRvdGV2DQo=
