Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A421ABA33;
	Thu, 31 Jul 2025 16:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753979651; cv=fail; b=d1jweB9whZAUsnPtZnU3VW9+32PhrvkPKlVhL8Snmxutbpn/SXrgwEPz1n2QIhL8503gV/b8WtqqqfN7l3zT2q+g/IaT+7lZJm2Hz34y9r97yqD01fclOL+eQ+GIKBhNt1RPcTB+SehvQFEQl8YRllNpdXssgpVKa1G3vYc6REE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753979651; c=relaxed/simple;
	bh=57koDtAMPPLzTfNoCXlI3hK75rq+7yCWwhLWpGSODZw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=qF1AtZ4CRE/p4Dma/4ZKolKoFNE1RNgqDkfXQjQy03mMIJdbI6dEp2lf6uT8kgXFWxgkvK+PVKi57Wr69P5jvtwatTcxdEXIh6eg6cWKzQ9gDy01+Pch5dLyeYWfpYdYBKVlqp1CPWuw2DFjBrvr8KXhfKc9jx+gMc5N6rEFpKI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=p1i/lpjt; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=eXf/73zK; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="p1i/lpjt";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="eXf/73zK"
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56VEuJTN010498;
	Thu, 31 Jul 2025 16:33:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=REufnip0MBQgl+QKpKSiRYd+MaXJr8uWFZ6vRmN8me4=; b=
	p1i/lpjt2MPoN6LPSLyDnfu1wTaIAnIy0SZ32MSwgXCiA8ADsBfI9qksIuaUHlBO
	dHcazIuXolS6sCk8oXzEgPW5RyCyt35dYebQssbQIjePsn1r2IMLxOGr9aZNjrgp
	ZzaH1w4hrGtUq86p71JkH7eiZvGCXS44vD0kiWlsjNtp7MnPs9jvWUdrv9hGOEbN
	4e2sgoDOrd9v0QCBuzfTGWoGLnB3FsVXr2RlY0/qUrvPioE5G/PgRE60oiXv7b0o
	qJUrHWuLLjR2DTyageKo2o3QwHopSRfpbrTIffRC7lySPF9nIyv2gzoCijFKyePE
	x2EZjfI6pkXU7rmrz4rNMg==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 484q4ecn4g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 31 Jul 2025 16:33:58 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 56VFflSX020847;
	Thu, 31 Jul 2025 16:33:57 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04on2066.outbound.protection.outlook.com [40.107.102.66])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 484nfk1cbv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 31 Jul 2025 16:33:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QZDfQ/DcTVXeyVGsicqfAj+V3sdeqnJwBGghMkd94YLRez2ORN4sGre25nq4mJq/c6+/huW5EH9zdU8jm+UnaM1IIXgjGh6yzPuvt4AYpJH3eES3ENH1xF0aoYoUtSSL5RFFJBvH9S5R7O74Jd9+KTjZqa5EbqfQai2DnOr6gnXqV1/JDp06QDwO4v8RpnXefu+coCrpExnuBai9mgZOMC1axVcv4a/LwTysEDzuR60V50fHU9aSa4hjvQeacxZz2/RA/x1geMh5y0Nf9+V/wtGUqbjqouI6FHFdw1+KKKwOxny4Q3iUr2GHT1/ExOrenFlV/+FQ+5/6yX9F1db1qA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=REufnip0MBQgl+QKpKSiRYd+MaXJr8uWFZ6vRmN8me4=;
 b=nunmR8hWw17JiJUZfY7+TvMfVMxgszn3l+pM5//XEFMs56OX5F2agRIpkxKjWAxJLaq1xMW7dfYeI8o74S6RVOci7Sk6hlQh3+dSdO//irvcbeXNepHwj7/K57LnX5AuElLE7U2EpbypZUCuabhGnht1YmYMIGZTxf/iXhuQs4VXMOVDCIbdUxS9iCnB97fHPKtxQV2rthirBC8gw0eVPBXwH6e7uab1bLhSH4YF+puOOMRGvXqaeq1YvSipKluDe7/RmRZXR2k5QnBRmpTrMU9qJIpKA491oi4M4mb4dIa9UazzE0giTVt+1+RYL5JZjaWWCSqagTo/DLLlcsCnhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=REufnip0MBQgl+QKpKSiRYd+MaXJr8uWFZ6vRmN8me4=;
 b=eXf/73zKj5UOh9OG5nvts8UVKmLXGugTVmxaHRgS/WterjixU6YQIPoqiiHi0tIRUjS4D/O7+TZsi8IBaUrIlg5QLu59doux/v1UWCxa2YvPqlpP86NXDzzwfMUMdHCI2hmsBNNBTm6DPdH/CAxBjUFp23xIR55aVZxlkK/seKY=
Received: from DS7PR10MB5328.namprd10.prod.outlook.com (2603:10b6:5:3a6::12)
 by DS4PPF9C7B9A88F.namprd10.prod.outlook.com (2603:10b6:f:fc00::d36) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.25; Thu, 31 Jul
 2025 16:33:55 +0000
Received: from DS7PR10MB5328.namprd10.prod.outlook.com
 ([fe80::ea13:c6c1:9956:b29c]) by DS7PR10MB5328.namprd10.prod.outlook.com
 ([fe80::ea13:c6c1:9956:b29c%5]) with mapi id 15.20.8989.013; Thu, 31 Jul 2025
 16:33:55 +0000
Message-ID: <25636f64-7b15-41d4-9ea6-216c22d84be4@oracle.com>
Date: Thu, 31 Jul 2025 22:03:46 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [External] : Re: [bug report] staging: sm750fb: Fix polarity
 assignment for vertical and horizontal mode
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: sudipm.mukherjee@gmail.com, teddy.wang@siliconmotion.com,
        gregkh@linuxfoundation.org, linux-fbdev@vger.kernel.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20250723192528.77109-1-alok.a.tiwari@oracle.com>
 <dbd2df69-27cc-4fd8-8e5b-78b6872d5d16@suswa.mountain>
Content-Language: en-US
From: ALOK TIWARI <alok.a.tiwari@oracle.com>
In-Reply-To: <dbd2df69-27cc-4fd8-8e5b-78b6872d5d16@suswa.mountain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO6P123CA0054.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:310::11) To DS7PR10MB5328.namprd10.prod.outlook.com
 (2603:10b6:5:3a6::12)
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR10MB5328:EE_|DS4PPF9C7B9A88F:EE_
X-MS-Office365-Filtering-Correlation-Id: 94dc21bc-aac6-4f0b-f175-08ddd0500a7a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dWxaMVFtU2pFczVnbTVSS0NWUVI1VWpZNXdWNGR2aEpYaVZtTDlBQkxPdUFp?=
 =?utf-8?B?RVA5Q0RLSk5WMXRHTXRjWnROOHFRQTMyK2ZyVndpeDZoNGxhOGxPQnYyTnN6?=
 =?utf-8?B?RGVJQmdJU3pzVWpXUnJoZkJEU0o2blRPY1RLUDZZRGNEQWdjcEhxRmVjK2gz?=
 =?utf-8?B?V1NxOEF3T0NRZXNnbjBXay96eVVVVGFrbWxHdzVxMk52Q1JjNWpaNVI1RUdL?=
 =?utf-8?B?cXpxWVVONmN5UTNJQytOWUpMWElPTkFtVC8wczNJby9vSkJTeWNXWGhUYVE5?=
 =?utf-8?B?bHk0UXdUdnZLMEdRNVJOQkppMUpSU1ZYTUgyVzhDTlN0VDlIem10Y0hweFlT?=
 =?utf-8?B?d2ZEVCtaK0JMMW9lNDJrTVFuUHNmeGgzU1U2UFhWVlkrRTljdnBaVzBxYWJB?=
 =?utf-8?B?VEQ3eWFyN3E1WVhXODBlWTJGcHNLZEkwYWNIbGVWQ3ZRQmV0Q2JsRzh4dEhI?=
 =?utf-8?B?ZVJiZ0ZwZTA2TmEvODkxOVNYVEN2eHEvd0RqWGdRaW1Mbnd2OEZBMHQ0K2xj?=
 =?utf-8?B?SGY2bStzZUdSZFFCOW1kNmQxVExqamZ3TDBMNGNFbkdsRE53V01aQTR0Qlhh?=
 =?utf-8?B?SDJ4anZLa1hHTzBab2c3SXBEazlpdEcvVDFadkNZNUJYNk5HWTE3NlI4N0Ni?=
 =?utf-8?B?em1rZU1vcStSQUo3ZjBkekhFa2E2bWN2R05OOHNhOEhtTWRRQzN6S3hNTG4y?=
 =?utf-8?B?UUZDaTU5cngvVDkvWGJhTkQyZEFHN3R2bzFqNFpYbEExbnA4QW5EaGNaeFNa?=
 =?utf-8?B?c2U1a2Z4TTFEeDdjVzlWVWRqMUVQaklLUGwxbDJKdk4wTU1nV2VXV2paVVl3?=
 =?utf-8?B?Z0dMQVNSSTJYWTA5VUsrY2pvTW5sZE50MnhMUTg5dGJyc1l1QzZ1ZlptbVox?=
 =?utf-8?B?YmgrMThFaG9BMlhWa09yY0ZpNlowemY2QkdXSXFtYXhydVR0S1lIOXBSZVBQ?=
 =?utf-8?B?RXloZm9UQUYzWWFIdlhxT2Nvc1JoRjhmcmNvbngwZG9WVHZxTThuT3N0TXZ2?=
 =?utf-8?B?UEplbmVZNXRoTDdEQjEzZitibjJhbWFsQnFJSTQvTVBIN3FvYUZXZFpWZWxH?=
 =?utf-8?B?SFB2dzVTT0x0K2FOYlprMzNvMnhOaFlJajkrcC9LNFVtMXRUZFA1RmIranFN?=
 =?utf-8?B?Wmh5eW5vazArdkRqcEJmSUs1WmF4cnJFOTRYRnBrZnpXcng0MUd4U2xaZFVs?=
 =?utf-8?B?VW1keEJ4YlhQOE1nS1NPV1BndmY5NmJtaFlZdkhuQ0diMDFDK0NsSnk2REFL?=
 =?utf-8?B?T2xzVk1naDhHZGwvUy80d01BUCttK01vN04rQlVJblI1V2dOOWFqQU9aVVNj?=
 =?utf-8?B?RytVZDUwYW95dXRyajRiZ3dsVGthYVYvUEpjYXRZZmo5UHNqSXpFcGJ5TGZY?=
 =?utf-8?B?a1lsTUhNamxJRGlQMWkzcC9Wd3JvZ3J0QUZLS2tqK3lvV0FNRHhkU0UwZjFo?=
 =?utf-8?B?MnZ2OXJpR1NsbGJWZWd2Y3EvdTh6ZkVkbjRwdlJyN1hBY1FGempUYWFXYk9s?=
 =?utf-8?B?cXNWd0lIcG40WVlrTkVDNGkwZlRwRHZsVjlHZlBVek1sL0UreGFTNlQ3QXRK?=
 =?utf-8?B?MHcrVWNiZXUrNDdEc0dVdFFqWmM5L1laOGtDaHMyWkJxN1NoSXplZ1AyVEVN?=
 =?utf-8?B?dDVudUpuVlZreWZsdU14QWhtZkNvQVQ2d2YzaitncG5CYmxsUUw2Rk1DbklI?=
 =?utf-8?B?bmZrZG83YTdhWjVDY3pxd2pLRjlNdXhQcGlRSDdjQzJ1K1lFdHpRNlBWbnBG?=
 =?utf-8?B?aEQ4VUxPdWtrOUdlaFVPSmRsR0VmUzVtTVNyd3J5VjlaalJwTXJWTjgwblNN?=
 =?utf-8?B?ZkpxMGlobCt2TWRkTVZCYkZST2hPcDZ2OWxKc0JZaHg4UVBUN3hHWXhZdUlT?=
 =?utf-8?B?MktSUGJpaU1mVzVzczhSNXRDZjNsbUhOblVHRmRTUWd3ZVhjQjJqd0xSK1dO?=
 =?utf-8?Q?2PE/s3tfwDk=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR10MB5328.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bXAxOFZIc0pYeHdCZXNWWHdKeEsrWGpwU3lFWFRycVZZTExGS1h5ZmtscDlx?=
 =?utf-8?B?UTBiSDhQajdXMVN6M3IwdHRvUVpFTEFEWmxLQXE5SW9TMzRYdkN3dUVPQVdR?=
 =?utf-8?B?YzdqN2tqdjJlcFpsWUdRbUZyTEZqVGhXbDBpVVcxWTQ2eDZHc1dyZFF5SmVS?=
 =?utf-8?B?Q2dwU3QxLzZRMnJ3RGNLK3N6NDhoc1A4b2dJUlJERTBJUEVHMUNiSkVNam9p?=
 =?utf-8?B?VHdaK09OYkdUSkhjbVVGbkFicm0vdTZoTVB2Wi8vRGNjSGJ2djBYazdkdHNq?=
 =?utf-8?B?V1ErMlBNczgwQ1MxSGxja1NyZS9wQUE1U2xBa1pHVjFSU0hIWm9sT2lWREsw?=
 =?utf-8?B?aXlVcGpEWjRBbDdGWHVkeVY2eEZxT0ozcmxUbHNlVjZJYWZLWjQ0d2syb1Bh?=
 =?utf-8?B?MFozU1ZlcFdHaGZPaU1KYS9QTllWMkRDNzE1UHcwSGt4elFJRWFYZWtORFZh?=
 =?utf-8?B?cG4vdit3amVUak0xZzFpYUVLc1FYOWxFbDcrQTdWTVYyZXpHbGI1NVVmc1E4?=
 =?utf-8?B?emRtK0ptUUpsY0FlbWd4M01ucWF1U2FKQjYvTm9GVnB3VUhLbUVRMDhqY0tN?=
 =?utf-8?B?RmE4a3lFTXdHclExVkZUMTNBWFlZV0JWZzQ4cnNKTExhU3dDSXFBaVdkQnZH?=
 =?utf-8?B?dEp6dVFaRVJFUVk5TVYxL0VabGlLeTdna2k2dHYrQ1ZjbWEzQ3RZTlJMbkp0?=
 =?utf-8?B?aWFiejA0Qk8yaWJINWErT1FoeElvTE5zRDY3RFlHN3VHMCtpdWJYUmwvdi9i?=
 =?utf-8?B?Z3I2elFvdWIzK0JFVnp3Yll3VERMOVJ0bnpTNkx1REIxV1dwODhGK1ZLQkE1?=
 =?utf-8?B?clNsZWpQTmdpQXVBbjY5ckFsYjRUc3dkUk8rbWFodXlDazF2VzkreWY0NXZJ?=
 =?utf-8?B?cG5Pa2R6RzlCQXlzNExKSGF3UzZJbjVzWmVUVVp2NkNBQWlHMEFncElHOUIv?=
 =?utf-8?B?ZGZLaUMyOTlpd0ZmbTkxVWE5RTc5ZzB6aTVxRHFsTndNRlNKbnFNVWFFNnBO?=
 =?utf-8?B?cVVnQkRIRlhrR25OaWt4SW9oVCtrYzhsWHhSZ3luUk9XVWZVSHR5bVRyK2l5?=
 =?utf-8?B?dnZEWVg1MHVzYUZiT1VBS1BMaEsxKzYrQkFqMjhkbUNObW5UdmNZTmwzaC94?=
 =?utf-8?B?MzNBbUZCdVFRYkdzbVAzaDdWUlhVTXJsN3BNU0RwcytXb3NPbWlGVXNrUVVL?=
 =?utf-8?B?Sm5wZC9DWk5ZMjR0SVpmSmN5NklhT1E3RjV0bjZDV0YwbDhnTkRySnpvcmpP?=
 =?utf-8?B?eVN6MEZCK1dseURGWUFldks2K1VvN2d2bDFvK21VajYzZ1g2bFhFcUZHaU0r?=
 =?utf-8?B?V1NueTkxbzFHcVUydHdpbHRVSlhYRmFWTjlCUmR3VlNyR1hlemRpVGdIZzE1?=
 =?utf-8?B?aFBSTE9xVkxRaEtpMTVXaExZTWRlVjYveERITktHTnVWZzFrMlBWc1gxeUtl?=
 =?utf-8?B?YU5vRVBmeU5jNWRyYnlnWUZqNmNLaTUrZ1BtckRyUEJUVG5RTGxvc0NZSE9v?=
 =?utf-8?B?bmlkelUxSmFmVVh6TC9MOUlzb0VDZkx2MVFXOUdyVEpuenFFMlRCZnFPeHhm?=
 =?utf-8?B?ekdzVkx3OCtmb0ZvNkdEaThESCtYb0xSRWJRenhMQWdRSVo1STNnUFJBZThp?=
 =?utf-8?B?Sk1VUGpBaDVITHRGNWFhVTR4TUE4VGxTVll0NDl5bk5yY0g1WXlqclFTNmIw?=
 =?utf-8?B?WFJ0NnVMbk5xSFQxK1N4dU1NT25YcWlkcTE3QzBjQ3YrNS9yUEZ0eWRaMDBu?=
 =?utf-8?B?M2xkcVFqTUgxb0xyTktpS1VZZFdXRjFOdzVSSDZPVWo5M2E5VkRTcGVLU3Nt?=
 =?utf-8?B?bml6VEFYa2pqL3hyUU1mbzd0TUltSTR3VW1GeHROZHVVQ053NXdiRitKR3A4?=
 =?utf-8?B?LzRsWURKcmh0cnA1enFhZi95cnFEV1o1cytDbVJxOTlSenhHNkNNK2Y0M2lE?=
 =?utf-8?B?ZDREcFhoM0hXdUllUjhSWEk0eEtlVXV6Y0ZkY3BwbEFCQUNwVGhHZXp5YitH?=
 =?utf-8?B?eXBLR0F1THVPZkYrNTlVMU1wRlA5TG1nQm9jcTlHRnpPVkY2c2ovcFBUYkhF?=
 =?utf-8?B?VXlDR3hBVDcwcG9QTHlzWHk2M2xFQUFkVW54UmV6NXNhTjFHNGhoRnVmUTRT?=
 =?utf-8?B?eHZmNFlFRFpRaWYzMnJiNGtzc21WdE5ZSVdKVDFta3FpS1lqYnM3Y3JHMTdy?=
 =?utf-8?B?M1E9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	ecRucq2XHOVuA0pbV8rXNpAVN+SP3U73WSw85JY5BuXUeoPOn5MiEsJbu6j1lxUMzyJxNhEmETyh5qZHbgVIx9rYr8LjNHZkcwPIx/tGdDwrGr1iIRBL3zmsknVkOCbPKviKTcLCjPOuI16Aa5rWH6PCWNm44bEfJUHHjP3WjGru6/W5frN+mS6P+FCAz//A712ulfHUaMzBsH1VkanqDJ6BQdds21RyIIMuVUsyAYUg6WTEEuiPtiP6ffpmvMVHFJMBcW+fUoWaFiisLX88isFbjCQ03ztGEV8PyC95K65VBm2KGxDZoYhOgCHnWEwahGY0xPlGHzRCoJdbiyQ+U8P0MazhYLIm+P9TxifpYKa5N1Qx+Cni8RL/Ai1uXCmcs+DI9dRkFrQba666NZ4oJ9Zotz0m5Y1cxqiMaq99tfUd3acksFyy7CPA20WVz4YNW2IpVepPsi3PfnKC93ciwy7L0OVik3bkjEWzj9Qs41mCU2wBPLHEA/em8X5joyjq9AFFlX/1ZccSSeQoieBiuaEdLQD5gSqtAAHT0sG4ITnVALaetRuaOCFF9QVprcY4hhHR3rlpz+F5ePCnnvVi8EurLpw5QSsa1wKHWAEQH4E=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 94dc21bc-aac6-4f0b-f175-08ddd0500a7a
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB5328.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2025 16:33:55.1572
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rR1VFp2EZM9VwYQHaPf0jBk2+UfRcRBfFiQjtnr9xUiVdMsFQH+hBjWF3RgTs8HQA4LDMN8nxpzv9B6pyy+aMMSljel8Ypk5ktABeSaOZ9s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PPF9C7B9A88F
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-31_03,2025-07-31_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 suspectscore=0 bulkscore=0
 malwarescore=0 mlxscore=0 adultscore=0 mlxlogscore=999 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2507310114
X-Proofpoint-ORIG-GUID: 3hDxc7plRHv4HblLXpg9A4ai7gBcOdIX
X-Proofpoint-GUID: 3hDxc7plRHv4HblLXpg9A4ai7gBcOdIX
X-Authority-Analysis: v=2.4 cv=QZtmvtbv c=1 sm=1 tr=0 ts=688b9af7 b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=m3SlSb3CSSFoEzx8zh0A:9
 a=QEXdDO2ut3YA:10 cc=ntf awl=host:12071
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzMxMDExNCBTYWx0ZWRfX42fTSkvBzEtJ
 cEU8KVEQBXnHwKLOTg/OaAC+0jIrjr2zpeGlHVcPY2a7r3jC8qt+ZF7niDMSHSFjdnZTBvGhTWc
 tWQesjoGeYFDTFtphJeWrgSSXZyQdVSHCXEcKtJzkrcuSiqrpA5wV1a3B5+gqVo0ja/ZQdjWh3s
 UOeVEniMdOHLTmboDQ1H5j5CfovRVMUJBcJZNZTmBJCKouou4DAFVeEZrPWTZHKmFajFv0ZoetA
 +Pp8N3Gd9t7IKfF6r2nmBhO/3nm5pWLE4iTWaV1vXtUl2hxh/j2wkPJ5i0WHNpqc9kK+Ffu1UQF
 xWtAhT4Jli1kiuAJDgmmSj4hZqmPPhmH761lVdfjDWAB5SadG0Y8v/wDkxPUcGH0zPRa9Aklu4i
 V9FHRdNvHLFkdsB7EI/gQhUBS5R7d3PtTWE0g7qju5k4DsBJUNtWRGn3F4lv2r6JssMToWpV



On 7/31/2025 9:41 PM, Dan Carpenter wrote:
> On Wed, Jul 23, 2025 at 12:24:31PM -0700, Alok Tiwari wrote:
>> In drivers/staging/sm750fb/sm750_hw.c,
>> the vertical and horizontal sync polarity assignments were incorrectly
>> ordered.
>> The assignment for modparm.vertical_sync_polarity was mistakenly using
>> the FB_SYNC_HOR_HIGH_ACT bit instead of FB_SYNC_VERT_HIGH_ACT,
>> and the horizontal polarity line was commented out or missing.
>>
>> This patch corrects the logic by properly assigning:
>>
>> vertical_sync_polarity -> from FB_SYNC_VERT_HIGH_ACT
>> horizontal_sync_polarity -> from FB_SYNC_HOR_HIGH_ACT
>>
>> Please let me know your feedback.
>> Thanks,
>> Alok
>> ---
>> Fixes: 81dee67e215b ("staging: sm750fb: add sm750 to staging")
>> Signed-off-by: Alok Tiwari <alok.a.tiwari@oracle.com>
>> ---
> 
> Did you find this copy and paste bug by testing or reviewing the code?
> How does this bug look like to a user?  Please put that in your commit
> message.
> 
> This looks reasonable to me, but the patch is badly formatted.
> 
> 1) It should say [PATCH] in the subject.
> 2) The body of the email should be the commit message.
> 3) the --- should only come after the Signed-off-by line.
> 
> Try applying your patch with `git am` and review the log to see what I
> mean.
> 
> regards,
> dan carpenter
> 


Thanks Dan. By reviewing the code, I noticed some awkward assignment.
However, I was not sure about this code, so instead of sending a formal 
patch, I just removed my SB and marked it as a [bug report].
I will send formal patch with proper SB.


Thanks,
Alok
