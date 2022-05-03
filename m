Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D02C0C433F5
	for <linux-fbdev@archiver.kernel.org>; Tue,  3 May 2022 12:29:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233082AbiECMd3 (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Tue, 3 May 2022 08:33:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232602AbiECMd2 (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>); Tue, 3 May 2022 08:33:28 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82F9B37AA0
        for <linux-fbdev@vger.kernel.org>; Tue,  3 May 2022 05:29:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651580995; x=1683116995;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=+sy8HXBACUts5VPZ/x+aKT1d5DCw4cPz8hnJkL6ccuc=;
  b=RlKI+tyI3Qn9fclkWdtcocwUp0yi+Ec/vmrV/YqW2204jefU3SKAh7VG
   MR+Ttjk9HSAKBUzas3fmg0VajbDT3g39L447Bi2553nUJwUJjzYcAE02B
   FLZOFOxoMMrdECeBM0kdeHrzRAVaRdLLig0qlNpOFITMtyfgWmP+WfbeU
   MCHQOzR0rdDo0KdQYB3fSzLtVYoZGeZ2IGl9+GfJpfBCi8U47xSdh23V8
   5IlrS2KAkoyj3KuUFm8wiTvsBhz+6lYALRvkrkLJBaVg8ODTfx7kpKtUU
   gSaR37/SDZsdsgAdL+/FffwFNnfpuBMRX1CMy7YlMexZ7vEZbxUhcAMRb
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10335"; a="267619031"
X-IronPort-AV: E=Sophos;i="5.91,195,1647327600"; 
   d="scan'208";a="267619031"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 May 2022 05:29:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,195,1647327600"; 
   d="scan'208";a="547472780"
Received: from orsmsx605.amr.corp.intel.com ([10.22.229.18])
  by orsmga002.jf.intel.com with ESMTP; 03 May 2022 05:29:54 -0700
Received: from orsmsx605.amr.corp.intel.com (10.22.229.18) by
 ORSMSX605.amr.corp.intel.com (10.22.229.18) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Tue, 3 May 2022 05:29:54 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx605.amr.corp.intel.com (10.22.229.18) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Tue, 3 May 2022 05:29:54 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.46) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Tue, 3 May 2022 05:29:54 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RU6YxH3z51RyXiRg8LYvnykcTEVdbRNy6FFXO2BHkqxNqfK3F5O1eJNMBx6U6mwnKDx/3t0xKL3P8s5Y/tXgdZ3VgUUYY9EHOsdPYHACap6Um+EMbMTvmPmDimiROwyDFhvqlxXYRQGw0YktOIIzF1qfv/RcJEzQIghIpxJhSiF67N/k1zZS1VuWz4oTwVuSSvGjUSipiXlPbSZ6Mnk2uUGzpl4KTkSXd3ORVN11qufHwtU4E6NU5JdG8vA9gq2JEoOk6VcL0sBg7I2JN8QHKVQMSAS5bilWjClOvh27F1mgI4DboJ8c7To5m3OK2sLAVG4v+P0Ssy3LdfRqESUoAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+sy8HXBACUts5VPZ/x+aKT1d5DCw4cPz8hnJkL6ccuc=;
 b=l86dPQI7OhWo/MymVLhSGMziHUCu+d1y8ig5OYgT/1wrsmDd76fUvoNgYI39CXn7rM6HygwLZmyPgZK+Xj+OQPOA7ivFFh+JgPLfSQBCAOjgRGXmIPdnfUTuufMHAzMyDSbShxqOEULZAM8PlL+6/Jb7oFp/lL1amRTxKi7eSuG6pq1qKa92V2wKc6r0zjiQg0yOrfNIS4B8/5erZTyXamooTAnmE0yZj9Teink8aT8xSzfRq8bqNNvA2gjFOTHqMduAkfNtxgW7ETDncgw8FuJk1JorfDXbAk24R4+j2peWn4oJ5/7IAgj4QAnJTqBWbl2Xnl9voTWChLNrsUHUEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5370.namprd11.prod.outlook.com (2603:10b6:408:11b::8)
 by CH0PR11MB5218.namprd11.prod.outlook.com (2603:10b6:610:e1::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.13; Tue, 3 May
 2022 12:29:53 +0000
Received: from BN9PR11MB5370.namprd11.prod.outlook.com
 ([fe80::593f:5bc9:6120:b40e]) by BN9PR11MB5370.namprd11.prod.outlook.com
 ([fe80::593f:5bc9:6120:b40e%7]) with mapi id 15.20.5206.013; Tue, 3 May 2022
 12:29:53 +0000
From:   "Chang, Junxiao" <junxiao.chang@intel.com>
To:     Thomas Zimmermann <tzimmermann@suse.de>,
        "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>
CC:     "lethal@linux-sh.org" <lethal@linux-sh.org>,
        "patchwork-bot@kernel.org" <patchwork-bot@kernel.org>,
        "deller@gmx.de" <deller@gmx.de>, "Li, Lili" <lili.li@intel.com>,
        Javier Martinez Canillas <javierm@redhat.com>
Subject: RE: [PATCH] video: fbdev: don't remove firmware fb device if it is
 busy
Thread-Topic: [PATCH] video: fbdev: don't remove firmware fb device if it is
 busy
Thread-Index: AQHYXD5CaeUMCFvvAEmVWevDAY4rPK0LMruAgAEaEyCAAHYQAIAAVbyw
Date:   Tue, 3 May 2022 12:29:53 +0000
Message-ID: <BN9PR11MB537070E36D25158B265C8490ECC09@BN9PR11MB5370.namprd11.prod.outlook.com>
References: <20220430025749.2320824-1-junxiao.chang@intel.com>
 <ab099144-2db2-caae-7a59-94211111a6cf@suse.de>
 <BN9PR11MB53709B93930F49194C0E5757ECC09@BN9PR11MB5370.namprd11.prod.outlook.com>
 <941d416c-63a4-aae1-0b9a-bda8211114f6@suse.de>
In-Reply-To: <941d416c-63a4-aae1-0b9a-bda8211114f6@suse.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2c730bc4-e2f2-4bd4-f6b6-08da2d009fee
x-ms-traffictypediagnostic: CH0PR11MB5218:EE_
x-microsoft-antispam-prvs: <CH0PR11MB5218FA85638C04F19FA4F2DAECC09@CH0PR11MB5218.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: BKI0pnVJALb0ZI5t6MgKFHBGwHcrqOJGhVWU6X0YT8KKFVDlo/8FuwrUIDZeVIuUbFNtV7pfkEyFKS72SG18GFnXbiUZ7S6QRgTBUrQ1Lvz+mKN+/h/jf80j588NhKWoiJQLHYw2/EYe7nWHQHtSmztQeavY+fgJcOa8gKm3oNWi7xL/dA2ScAc65+ZBFs7fzwv1T2n5q7AtDRvmdO6z2mEvU0OD9zZQbGw4AaDKuv59xbFkJUpzUJR18LOZ1JzLHdEdwcA1xDB/oOEHnPGaBzH4GfRyuWnVsYGFkYjI024mh3GhwVH692YjfqKYSVCat476zFcF5oxJuqF5HZ1iD804MBy77JjUFoAgj4A0oXx4Bi25HAuoiFwrIIwZVqV1UPLIExtuTAP9V8FpupskgpbK9PfVBoeD4BeIQtlDoiNE+HmT+2cna7I3QDi3Lu4jawpsbxCnUnmDSdzWm4qpi1ELmyHa1MdDr1wx2uQ/7Uak+CgaRlof2irgp1sTc6r3q8PzrH3Q7aA1OtS1L0FbxMYiNio3CWgEQmNDw8Wx+HDPbGB7FCXVHLywYLPQ3KlKHxQnZ3YinsUzGYPcn6pxNWBGtclf/MxSZ6lsFk6apVQOuejz5yN3juWl5UKaIWAgC8z/uCNQeLmvJWDcASLah1wvCrph+wX35+2qzUENQ7+2l6LU4jwB2r+l5KTSlMMiuR0usbMWG896JvXjJ3KHOQGkLjz3DDCtG2xln9pJNBJgNQxb8Wyann/RluVlZgbI5ctJvgWd2WRZ+1+j6F5zq5FvC4LkmYzasO/cY+BYw/w=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5370.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(66946007)(8676002)(66556008)(66476007)(64756008)(4326008)(66446008)(76116006)(71200400001)(7696005)(82960400001)(122000001)(38070700005)(508600001)(966005)(38100700002)(33656002)(53546011)(54906003)(26005)(6506007)(110136005)(316002)(55016003)(9686003)(186003)(2906002)(66574015)(5660300002)(52536014)(8936002)(83380400001)(86362001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bW1ocm0zSy81TVZ3QzlxL1doRlJKZG95QldnSE0zYVM1ZDQ5QTBOM3ZIdlQy?=
 =?utf-8?B?YzVmSXppTXU1ZlR3djFBVWREMTdyNkhweVp2aU1DWVdWbmNzZUhNclJ1VXk2?=
 =?utf-8?B?WTVlY0IvMTZ4ZStHc1NaY0FZS0hlc2hzNTB3TWFOM1NFM0NxYUFRN2NYVzBa?=
 =?utf-8?B?b3JEekZJZUNWL3NnajRvUllOcC9zengvOGEva3BNbk0xdFdiVU12UlJhNHI0?=
 =?utf-8?B?c1F2N0hHck1qNzdxRE9oS21saUcveEFUWkgzNmpaanluZ1JmMWZDRStzVklW?=
 =?utf-8?B?ZXR5akxZQ3gxOFI4N2Z0OFh2cnZ2Q3ZDVGRlaGh6YUNUdXd4ajMwT3lJSDEx?=
 =?utf-8?B?S2hrbnpSUk40VSszVmhkamF4T2Q5TndENnROejVicVJPaUZoa2tMVUgrTUcy?=
 =?utf-8?B?Y2VKUnVoTldYQnJDOWN4c2QzMVp4MEdxU0VZRHFlZ0VhaUl4Tk5kUkFsRzVq?=
 =?utf-8?B?ajM1QU1oRTVaNk1WUS90QUxqWnMzdGI3eWM3b0djZzhlbzdBK1BFZ1hmeEln?=
 =?utf-8?B?bVRxaXR5Uk8rQWI0YVd0WWxWYXl3bWtKM0diQ2VHbHU3QUJPV2lSRVMrdXgy?=
 =?utf-8?B?YjhwcjhqUGxXeURpMHM3eThBQnlnQUZDNGlJdTRSaFBmNWRzazlkcDl2MGRn?=
 =?utf-8?B?SFdGOHh6NVNONlZuYnNrVVdMa2U5YjBXZnBIWkJJR0JObldXK2k0bTRsV3BE?=
 =?utf-8?B?UHVBaUxMU3VTZWoyaXAycnpKd0tScjZOVXFzR3NaWWlLZVpoYnR6UUVYd0lm?=
 =?utf-8?B?MjhpaHVXOW1sOWM4anREcU91WkMwTUllZjFjcXB0QlcrSkpHZjFrVHJIUDla?=
 =?utf-8?B?VXpIeGhVQTJFZVZvb3R6K0RkQ2dYa1U3MW5GUnJDeWJUTHZKUHMrNTNrRTZH?=
 =?utf-8?B?ZFdaTnVWWGVIcXdETG1HaEE3N3VNR2NsV2NLZDhaUmRNMGV4KytkRE1GbDVY?=
 =?utf-8?B?clJCYXQ1NnJKWFhUakFPdndDR1hxUmhBSHNyeFlxWFFPT0pNczF5NXZvbjdF?=
 =?utf-8?B?cWZJcWhSQ3hMQ1E5eXhuWlpLV0lyeW5GN0N5dzdONDdoNFZLdDU2SStxWTcr?=
 =?utf-8?B?SEpXamV6d1g5UDVYWEx1YkJjWld5Z0lFOEtiZEVycXMwV2NwVE95L3JlVTVt?=
 =?utf-8?B?TDgrTTJPeXJtQ3U1NWFBYTg3c21acElXaHoxeVEyWEVjMjlOSEhoUE9ISVVw?=
 =?utf-8?B?TitzbVVNK2xuZE9HMFBoeTBDdGhsTXNLVVV5ejJEblhqL0VBV3I3TUc4K2pu?=
 =?utf-8?B?bFZ5ODFaT29wa0hsRTZYNUo0VnlFbXlrY3RCbExHRk5vN0M3L3lKZldFZmdt?=
 =?utf-8?B?eHZqS0x2Y1A1SHJOeURyUnNuVnJieHFVN1VUazFHaml3YWFRNytTUHRjTGUx?=
 =?utf-8?B?RVptMU0reFdPYzdUcG4yMURUcXd3eTVROU4rQTVKMTJaMVJ2Y0VTUExYWTFa?=
 =?utf-8?B?czh5dnVMdGtGNGZsVWZsMEdKUVBLbXh1OEFYUzVCYXd4UHRWS0tBZ2RNMGRo?=
 =?utf-8?B?b3BiakJzeFM3YUF2aDRndjlpa1kxWHQxNVROM0dlMUNlWjhkenRpWTI0K2tu?=
 =?utf-8?B?Q1UxWnN1NnhkNnZPWU5EbzZjZFpuZkZKQk5XSUY1QXROZ2l1ZjdqOXZMOWlS?=
 =?utf-8?B?NTVDNDJFRkRnaEhQOCt1YlNKQWtNcVVBK2JENHN3eTVtbDI3L3MvMEx3UXJn?=
 =?utf-8?B?aEM0S2hHZ3BxbW1zZzU5TjVkRXkxSFRneU5mRGtpZldRS2M5VDdKcGhRaU9H?=
 =?utf-8?B?Rk1lcElYeE9FYlcwaTJrVUwvbE5CODhORUI5dzd0K1pGd0VpTjc1OHpsdG5y?=
 =?utf-8?B?VkhkQ0JRQmdDTW03N1BKOVRtK2tMMmt3RU9UMm1SSUQwUUhZay9RQVkvVHpF?=
 =?utf-8?B?dlhxT0dReGpoSHB1RW8rNWxic0NwdURKL1owNHk5S0NJc3YydFFjYmJTMzdy?=
 =?utf-8?B?cnNtTlhYOVZKeDh1WktzL0VuWFUya3F6QlZPaTBORXZLbWFwQmM3ekRPUHZh?=
 =?utf-8?B?Z2x1TGw0aUlVcUtSeFhveXlGR3JqMkJjVEJUaG8yclpJa1M2bGorVmtmSTI5?=
 =?utf-8?B?Mng2R3FxTUhqWUVva2JtT3lnRlROcnkrMmR6STRhWjBYRWVBSDlZSVRlcU5y?=
 =?utf-8?B?NkovOTIxYndQUmxpZjNDakF5L2VrTWc5ZCtuUHBxREJZNXllbkxnYU5zR2xa?=
 =?utf-8?B?Q1B4ekJCTjR6dGVCSExieittRWFGRDVpWUlrSzB4cmxSd0RlTjFhUzRVRUhh?=
 =?utf-8?B?L0xOZGdpSndSZnhBdjA3SXdQemxlUXJpVU1IaUZCN1pZZjBVL2pTWXBkT2NF?=
 =?utf-8?B?SE51VHJCMU9oWkdmcEhZd0t5QTY1REQwQWZBY25ZUmhLTGNwbzZGZz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5370.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c730bc4-e2f2-4bd4-f6b6-08da2d009fee
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 May 2022 12:29:53.2365
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RFowToXe2RqnlnjNgjXzPP7DNI1mMUXV+Uh+MNOLOo6OTCTNf7nMrgfpkZPbyXwpeVAJqtaDIuvG2RbU26IB4g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB5218
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

V2UgdGVzdGVkIEphdmllcidzIGZpeCwgaXNzdWUgY291bGRuJ3QgYmUgcmVwcm9kdWNlZCBhbnlt
b3JlLg0KaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvZHJpLWRldmVsLzIwMjIwNTAyMTM1MDE0LjM3
Nzk0NS0xLWphdmllcm1AcmVkaGF0LmNvbS9ULyN1DQoNCkJ1dCB0aGlzIGZpeCBkb2Vzbid0IGNv
dmVyIGFsbCBGQiBkcml2ZXIncyBpbnRlcmZhY2U6DQoNCgkuZ2V0X3VubWFwcGVkX2FyZWEgPSBn
ZXRfZmJfdW5tYXBwZWRfYXJlYSwNCgkuZnN5bmMgPQlmYl9kZWZlcnJlZF9pb19mc3luYywNCg0K
ZmlsZV9mYl9pbmZvKGZpbGUpIE5VTEwgY2hlY2tpbmcgc2hvdWxkIGJlIGFkZGVkIGluIHRoZXNl
IHR3byBpbnRlcmZhY2UgZnVuY3Rpb25zKGdldF9mYl91bm1hcHBlZF9hcmVhIGFuZCBmYl9kZWZl
cnJlZF9pb19mc3luYykgYXMgd2VsbD8NCg0KUmVnYXJkcywNCkp1bnhpYW8NCg0KLS0tLS1Pcmln
aW5hbCBNZXNzYWdlLS0tLS0NCkZyb206IFRob21hcyBaaW1tZXJtYW5uIDx0emltbWVybWFubkBz
dXNlLmRlPiANClNlbnQ6IFR1ZXNkYXksIE1heSAzLCAyMDIyIDM6MTYgUE0NClRvOiBDaGFuZywg
SnVueGlhbyA8anVueGlhby5jaGFuZ0BpbnRlbC5jb20+OyBsaW51eC1mYmRldkB2Z2VyLmtlcm5l
bC5vcmcNCkNjOiBsZXRoYWxAbGludXgtc2gub3JnOyBwYXRjaHdvcmstYm90QGtlcm5lbC5vcmc7
IGRlbGxlckBnbXguZGU7IExpLCBMaWxpIDxsaWxpLmxpQGludGVsLmNvbT47IEphdmllciBNYXJ0
aW5leiBDYW5pbGxhcyA8amF2aWVybUByZWRoYXQuY29tPg0KU3ViamVjdDogUmU6IFtQQVRDSF0g
dmlkZW86IGZiZGV2OiBkb24ndCByZW1vdmUgZmlybXdhcmUgZmIgZGV2aWNlIGlmIGl0IGlzIGJ1
c3kNCg0KKGNjJ2luZyBKYXZpZXIpDQoNCkhpDQoNCkFtIDAzLjA1LjIyIHVtIDAyOjM4IHNjaHJp
ZWIgQ2hhbmcsIEp1bnhpYW86DQo+IEhpIFRob21hcywNCj4gDQo+IFdlIHJlcHJvZHVjZWQgdGhp
cyBpc3N1ZSB3aXRoIFlvY3RvIGltYWdlICsgNS4xOC1yYzMga2VybmVsLg0KPiBJZiB5b3UgY291
bGQgdHJ5IFlvY3RvIGltYWdlIGFuZCBlbmFibGUgcHNwbGFzaCwgdGhlIHByb2JsZW0gY291bGQg
YmUgcmVwcm9kdWNlZCBhbG1vc3QgZXZlcnkgdGltZSBpZiBwc3BsYXNoIGlzIGxhdW5jaGVkIGJl
Zm9yZSBJbnRlbCBpOTE1IHJlZ2lzdGVycyAybmQgZnJhbWVidWZmZXIuDQo+IA0KPiBEdXJpbmcg
WW9jdG8gYm9vdGluZyB1cCwgaXQgbGF1bmNoZXMgcHNwbGFzaCB3aGljaCBvcGVucyBFRkkgZmly
bXdhcmUgZnJhbWVidWZmZXIgYW5kIHBsYXlzIGFuaW1hdGlvbi4gV2hlbiBpdCBleGl0cywgZmJf
cmVsZWFzZSBpbiBrZXJuZWwgbWlnaHQgYWNjZXNzIG1lbW9yeSB3aGljaCBoYXMgYmVlbiByZWxl
YXNlZC4NCj4gDQo+IE92ZXJhbGwgcHJvY2VzcyBsb29rcyBsaWtlOg0KPiAxLiBFRkkgcmVnaXN0
ZXJzIGZyYW1lYnVmZmVyIGluIGVmaWZiX3Byb2JlLCBmcmFtZWJ1ZmZlcl9hbGxvYyBpcyANCj4g
Y2FsbGVkIHRvIGFsbG9jYXRlICJzdHJ1Y3QgZmJfaW5mbyIgbWVtb3J5OyAyLiBJbiB1c2Vyc3Bh
Y2UsIHBzcGxhc2ggDQo+IGlzIHN0YXJ0ZWQgdG8gcGxheSBib290IGFuaW1hdGlvbiwgaXQgb3Bl
bnMgZnJhbWVidWZmZXIgZHJpdmVyLiBJbiANCj4gZmJfb3BlbiBmdW5jdGlvbiwgaXQgc2F2ZXMg
ZmJfaW5mbyBtZW1vcnkgdG8gZmlsZS0+cHJpdmF0ZV9kYXRhOyAzLiANCj4gV2hlbiBJbnRlbCBp
OTE1IGRyaXZlciBpcyBwcm9iZWQsIGl0IHJlZ2lzdGVycyAybmQgZnJhbWVidWZmZXIsIGFuZCAN
Cj4gd2lsbCByZW1vdmUgY29uZmxpY3RpbmcgZnJhbWVidWZmZXI7IDQuIEluIGRvX3JlbW92ZV9j
b25mbGljdGluZ19mcmFtZWJ1ZmZlcnMsIGl0IGNhbGxzICJwbGF0Zm9ybV9kZXZpY2VfdW5yZWdp
c3RlciIgdG8gcmVtb3ZlIEVGSSBwbGF0Zm9ybSBmcmFtZWJ1ZmZlciBkZXZpY2U7IDUuIEluIEVG
SSBmcmFtZWJ1ZmZlcidzIGVmaWZiX3JlbW92ZSBmdW5jdGlvbiwgaXQgY2FsbHMgZnJhbWVidWZm
ZXJfcmVsZWFzZSB0byByZWxlYXNlICJzdHJ1Y3QgZmJfaW5mbyIgbWVtb3J5IHdoaWNoIGlzIHN0
aWxsIHVzZSBhbmQgc3RvcmVkIGluIGZpbGUtPnByaXZhdGVfZGF0YTsgNi4gV2hlbiBwc3BsYXNo
IHVzZXIgc3BhY2UgYXBwbGljYXRpb24gZXhpdHMsIGl0IGNhbGxzIGZiX3JlbGVhc2UgZnVuY3Rp
b24sIGFuZCBhY2Nlc3NlcyB0byBmYl9pbmZvIG1lbW9yeSwgYnV0IGl0IGhhcyBiZWVuIHJlbGVh
c2VkIGluIHN0ZXAgNS4gS2VybmVsIHBhbmljIGhhcHBlbnMuDQoNClRoYW5rcyBmb3IgdGhlIGlu
Zm9ybWF0aW9uLiBXZSBvbmx5IGhhZCBhIHNpbWlsYXIgcmVwb3J0IGFib3V0IFJQaSBkZXZpY2Vz
LCBidXQgd2UgbmV2ZXIgZW5jb3VudGVyZWQgdGhpcyBwcm9ibGVtIGJlZm9yZS4NCg0KPiANCj4g
T3VyIHBhdGNoIGlzIHRvIGNoZWNrIHdoZXRoZXIgRUZJIGZyYW1lYnVmZmVyIGlzIG9wZW5lZCBh
dCB0aGF0IHRpbWUuIElmIGl0IGlzIGZyZWUocmVnaXN0ZXJlZF9mYltpXS0+Y291bnQgPT0gMSks
IGdvIGFoZWFkIHRvIHJlbW92ZSBFRkkgcGxhdGZvcm0gZGV2aWNlLiBPciBlbHNlLCBqdXN0IHVu
cmVnaXN0ZXIgZnJhbWVidWZmZXIgdG8gYXZvaWQga2VybmVsIHBhbmljLg0KDQpKYXZpZXIgcG9z
dGVkIGEgcG9zc2libGUgZml4IGZvciB0aGUgcm9vdCBjYXVzZSBvZiB0aGlzIHByb2JsZW0sIGJ1
dCB3ZSdyZSBzdGlsbCBsb29raW5nIGZvciB0ZXN0ZXJzLiBJZiB5b3UgaGF2ZSB0aGUgb3Bwb3J0
dW5pdHksIGNvdWxkIHlvdQ0KICBwbGVhc2UgdGVzdCB0aGUgcGF0Y2ggYXQgWzFdIGFuZCByZXBv
cnQgYmFjayBvbiB0aGUgcmVzdWx0cy4NCg0KQmVzdCByZWdhcmRzDQpUaG9tYXMNCg0KWzFdDQpo
dHRwczovL2xvcmUua2VybmVsLm9yZy9kcmktZGV2ZWwvMjAyMjA1MDIxMzUwMTQuMzc3OTQ1LTEt
amF2aWVybUByZWRoYXQuY29tL1QvI3UNCg0KPiANCj4gVGhhbmtzLA0KPiBKdW54aWFvDQo+IA0K
PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBUaG9tYXMgWmltbWVybWFubiA8
dHppbW1lcm1hbm5Ac3VzZS5kZT4NCj4gU2VudDogTW9uZGF5LCBNYXkgMiwgMjAyMiAzOjI0IFBN
DQo+IFRvOiBDaGFuZywgSnVueGlhbyA8anVueGlhby5jaGFuZ0BpbnRlbC5jb20+OyANCj4gbGlu
dXgtZmJkZXZAdmdlci5rZXJuZWwub3JnDQo+IENjOiBsZXRoYWxAbGludXgtc2gub3JnOyBwYXRj
aHdvcmstYm90QGtlcm5lbC5vcmc7IGRlbGxlckBnbXguZGU7IExpLCANCj4gTGlsaSA8bGlsaS5s
aUBpbnRlbC5jb20+DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0hdIHZpZGVvOiBmYmRldjogZG9uJ3Qg
cmVtb3ZlIGZpcm13YXJlIGZiIGRldmljZSBpZiANCj4gaXQgaXMgYnVzeQ0KPiANCj4gSGkNCj4g
DQo+IEFtIDMwLjA0LjIyIHVtIDA0OjU3IHNjaHJpZWIgSnVueGlhbyBDaGFuZzoNCj4+IFdoZW4g
ZmlybXdhcmUgZnJhbWVidWZmZXIgaXMgaW4gdXNlLCBkb24ndCByZW1vdmUgaXRzIHBsYXRmb3Jt
IGRldmljZS4NCj4+IE9yIGVsc2UgaXRzIGZiX2luZm8gYnVmZmVyIGlzIHJlbGVhc2VkIGJ5IHBs
YXRmb3JtIHJlbW92ZSBob29rIHdoaWxlIA0KPj4gZGV2aWNlIGlzIHN0aWxsIG9wZW5lZC4gVGhp
cyBpbnRyb2R1Y2VzIHVzZSBhZnRlciBmcmVlIGlzc3VlLg0KPiANCj4gV2hlbiBleGFjdGx5IGRv
ZXMgdGhpcyBoYXBwZW4/IERvIHlvdSBoYXZlIGEgcmVsaWFibGUgd2F5IG9mIHJlcHJvZHVjaW5n
IGl0Pw0KPiANCj4gQmVzdCByZWdhcmRzDQo+IFRob21hcw0KPiANCj4+DQo+PiBBIGtlcm5lbCBw
YW5pYyBleGFtcGxlOg0KPj4gQ1BVOiAyIFBJRDogMzQyNSBDb21tOiBwc3BsYXNoIFRhaW50ZWQ6
IEcgICAgIFUgIFcgICAgIDUuMTguMC1yYzMNCj4+IEhhcmR3YXJlIG5hbWU6IEludGVsIENsaWVu
dCBQbGF0Zm9ybS9BRFAtUyBERFI1IFVESU1NIENSQg0KPj4gUklQOiAwMDEwOm5hdGl2ZV9xdWV1
ZWRfc3Bpbl9sb2NrX3Nsb3dwYXRoKzB4MWM3LzB4MjEwDQo+PiBSU1A6IDAwMTg6ZmZmZmIzYTBj
MGMyZmRiMCBFRkxBR1M6IDAwMDEwMjA2DQo+PiBSQVg6IDAwMmRjMDc0ZmY1YzA5ODggUkJYOiBm
ZmZmOTJlOTg3YTVkODE4IFJDWDogZmZmZjkyZTk4OWJhOWY0MA0KPj4gUkRYOiAwMDAwMDAwMDAw
MDAyMDY3IFJTSTogZmZmZmZmZmY4NjQzNDRmMSBSREk6IGZmZmZmZmZmODY0NDE4M2MNCj4+IFJC
UDogZmZmZjkyZjEwZjRhYmQ0MCBSMDg6IDAwMDAwMDAwMDAwMDAwMDEgUjA5OiBmZmZmOTJlOTg2
ZGMyMTg4IC4uLg0KPj4gQ2FsbCBUcmFjZToNCj4+ICAgIDxUQVNLPg0KPj4gICAgX3Jhd19zcGlu
X2xvY2srMHgyYy8weDMwDQo+PiAgICBfX211dGV4X2xvY2suY29uc3Rwcm9wLjArMHgxNzUvMHg0
ZjANCj4+ICAgID8gX3Jhd19zcGluX3VubG9jaysweDE1LzB4MzANCj4+ICAgID8gbGlzdF9scnVf
YWRkKzB4MTI0LzB4MTYwDQo+PiAgICBmYl9yZWxlYXNlKzB4MWIvMHg2MA0KPj4gICAgX19mcHV0
KzB4ODkvMHgyNDANCj4+ICAgIHRhc2tfd29ya19ydW4rMHg1OS8weDkwDQo+PiAgICBkb19leGl0
KzB4MzQzLzB4YWYwDQo+PiAgICBkb19ncm91cF9leGl0KzB4MmQvMHg5MA0KPj4gICAgX194NjRf
c3lzX2V4aXRfZ3JvdXArMHgxNC8weDIwDQo+PiAgICBkb19zeXNjYWxsXzY0KzB4NDAvMHg5MA0K
Pj4gICAgZW50cnlfU1lTQ0FMTF82NF9hZnRlcl9od2ZyYW1lKzB4NDQvMHhhZQ0KPj4NCj4+IEZp
eGVzOiAyNzU5OWFhY2JhZWYgKCJmYmRldjogSG90LXVucGx1ZyBmaXJtd2FyZSBmYiBkZXZpY2Vz
IG9uIGZvcmNlZA0KPj4gcmVtb3ZhbCIpDQo+PiBTaWduZWQtb2ZmLWJ5OiBKdW54aWFvIENoYW5n
IDxqdW54aWFvLmNoYW5nQGludGVsLmNvbT4NCj4+IFNpZ25lZC1vZmYtYnk6IExpbGkgTGkgPGxp
bGkubGlAaW50ZWwuY29tPg0KPj4gLS0tDQo+PiAgICBkcml2ZXJzL3ZpZGVvL2ZiZGV2L2NvcmUv
ZmJtZW0uYyB8IDQgKysrLQ0KPj4gICAgMSBmaWxlIGNoYW5nZWQsIDMgaW5zZXJ0aW9ucygrKSwg
MSBkZWxldGlvbigtKQ0KPj4NCj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3ZpZGVvL2ZiZGV2L2Nv
cmUvZmJtZW0uYw0KPj4gYi9kcml2ZXJzL3ZpZGVvL2ZiZGV2L2NvcmUvZmJtZW0uYw0KPj4gaW5k
ZXggYTZiYjBlNDM4MjE2Li5mZjliOTgzMGIzOTggMTAwNjQ0DQo+PiAtLS0gYS9kcml2ZXJzL3Zp
ZGVvL2ZiZGV2L2NvcmUvZmJtZW0uYw0KPj4gKysrIGIvZHJpdmVycy92aWRlby9mYmRldi9jb3Jl
L2ZibWVtLmMNCj4+IEBAIC0xNTg2LDcgKzE1ODYsOSBAQCBzdGF0aWMgdm9pZCBkb19yZW1vdmVf
Y29uZmxpY3RpbmdfZnJhbWVidWZmZXJzKHN0cnVjdCBhcGVydHVyZXNfc3RydWN0ICphLA0KPj4g
ICAgCQkJCSAqIGZyYW1lYnVmZmVyIGFzIGJlZm9yZSB3aXRob3V0IHdhcm5pbmcuDQo+PiAgICAJ
CQkJICovDQo+PiAgICAJCQkJZG9fdW5yZWdpc3Rlcl9mcmFtZWJ1ZmZlcihyZWdpc3RlcmVkX2Zi
W2ldKTsNCj4+IC0JCQl9IGVsc2UgaWYgKGRldl9pc19wbGF0Zm9ybShkZXZpY2UpKSB7DQo+PiAr
CQkJfSBlbHNlIGlmIChkZXZfaXNfcGxhdGZvcm0oZGV2aWNlKSAmJg0KPj4gKwkJCQkJcmVmY291
bnRfcmVhZCgmcmVnaXN0ZXJlZF9mYltpXS0+Y291bnQpID09IDEpIHsNCj4+ICsJCQkJLyogUmVt
b3ZlIHBsYXRmb3JtIGRldmljZSBpZiBpdCBpcyBub3QgaW4gdXNlLiAqLw0KPj4gICAgCQkJCXJl
Z2lzdGVyZWRfZmJbaV0tPmZvcmNlZF9vdXQgPSB0cnVlOw0KPj4gICAgCQkJCXBsYXRmb3JtX2Rl
dmljZV91bnJlZ2lzdGVyKHRvX3BsYXRmb3JtX2RldmljZShkZXZpY2UpKTsNCj4+ICAgIAkJCX0g
ZWxzZSB7DQo+IA0KPiAtLQ0KPiBUaG9tYXMgWmltbWVybWFubg0KPiBHcmFwaGljcyBEcml2ZXIg
RGV2ZWxvcGVyDQo+IFNVU0UgU29mdHdhcmUgU29sdXRpb25zIEdlcm1hbnkgR21iSA0KPiBNYXhm
ZWxkc3RyLiA1LCA5MDQwOSBOw7xybmJlcmcsIEdlcm1hbnkgKEhSQiAzNjgwOSwgQUcgTsO8cm5i
ZXJnKQ0KPiBHZXNjaMOkZnRzZsO8aHJlcjogSXZvIFRvdGV2DQoNCi0tDQpUaG9tYXMgWmltbWVy
bWFubg0KR3JhcGhpY3MgRHJpdmVyIERldmVsb3Blcg0KU1VTRSBTb2Z0d2FyZSBTb2x1dGlvbnMg
R2VybWFueSBHbWJIDQpNYXhmZWxkc3RyLiA1LCA5MDQwOSBOw7xybmJlcmcsIEdlcm1hbnkNCihI
UkIgMzY4MDksIEFHIE7DvHJuYmVyZykNCkdlc2Now6RmdHNmw7xocmVyOiBJdm8gVG90ZXYNCg==
