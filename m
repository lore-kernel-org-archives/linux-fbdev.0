Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A008D36AF5
	for <linux-fbdev@vger.kernel.org>; Fri, 21 Feb 2025 17:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740160417; cv=fail; b=V6WgjKAoVzF6+3l9BF0GHItSMq+mne+KmyaZdh0OOqfnmqTaB4RNS6xM1pX9md+l8u/YNgJsXn9il/qy2Du5MqVebj265hFjW8nb2u66QwQqiR+SxsiJvGtT2LDxg+4d1eCAjS7vWSiLwIdSvEP3TdBq6qV7fZmK0NTXWUHJzko=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740160417; c=relaxed/simple;
	bh=yWReyvAzrhN8PT1u4fOWsI2AU16XQ+0vElNrRo4rLyA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=oMOgoybqIP4EoAVdY23opvHm60ywoXpioIi8wlIGKKh/iXB8RhplqB45/+OCWe/nueXMhauSqMO6s7oAE52dCNOahtGQl5ljDAPlcDQRHKkzdiaM+Kew7mScbEANL/01RCIHWstEUIRYCShlZ/t4WIWHZHE+cGZNBc7fzZh7jCE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=O+P1Ev2l; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=R8iBBXdF; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="O+P1Ev2l";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="R8iBBXdF"
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51LHm0Nb018619;
	Fri, 21 Feb 2025 17:53:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=YbsDVA9/JrD0EyAAhF
	dgGm3Q4z9exxNDc6csx/HFPig=; b=O+P1Ev2loxojoHgWwN5VHsFtB4R5UvvCEZ
	eThkMn5nxl/gvP6BKRc8c8n5aJ53DE8T51Gsf2RO83dHHzvOcNJJWCI3dO48VTaN
	FewFArWHUr4VH8+3yib0lbniYRK9mlPSRy34xf6OLLWs17AAqD9unJVAu9wFrj+G
	5ZFCWWdnR+TYlW4Bf7SJIjponpdIPTQCOXBy+qdbcop8wKAmuFqn/b9DHsi4y9mH
	VQRqJkm7uhoCukuzUfHIjjSsFjYIucNOYyLppnstJsuHKYHs31YXjo2uvOawOiG3
	5eEPKNmPWTDUFFLTKltx0/UYpQrT28Q3jw8T/xy23fBij4o1vCZg==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44w00npv9r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 21 Feb 2025 17:53:22 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 51LGomqO002192;
	Fri, 21 Feb 2025 17:53:20 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2174.outbound.protection.outlook.com [104.47.55.174])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 44w0tq9ffs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 21 Feb 2025 17:53:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Y59PgEGikpNpAxtIOU4Pl9HhEajEqPjlTB97Z6WMxl9qzHqmSKaO2wXhQ4m8oHw+I4yPCFYma5nCUuDIuVVKTWZn9W5Cpc+ZomN9floTzddS8yKj3S5IbGl2CVR0N56he4Fpqr7yWEnXRlP2acxIbyWdzQ7GL6EMXNytTmLx2Nr4mROrbeNvI025l/UdMYARzK+xdVf2LLEJomF3SQ4fRw/L+JsKWk5cn3aYw9LA5naeAqs8xz0cT8ujFxfO8bqRqzemTAUQOItp0i0A8dKeDJOoMj6ir+8bLI3KsFwjibWDY7szCUKkGlfxwVNjro5DaPQngNGa/SolwN2NCJDh8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YbsDVA9/JrD0EyAAhFdgGm3Q4z9exxNDc6csx/HFPig=;
 b=xe10mk34/rZVUV+k5lUfvLg5khHL10loUzlF916fkFhPb6mllEXFm+nfaTPA84aEz9cIRz4fZob9s13kCh89pYQ3A9V6MwgSKBtmGJBkEEYxZzBJfU+JinPqWUa8IwHliUmfm/Yw6Fyj0tJDewZSTCYlCam53Q9fx75bTkGZKb1SH8ELMUZdnrZ2TGBmp0UMe1MqCsHcbbjq20nRKdfzxBcF5Dix+eIrmT+wcF2lgC28SoaU4Vdy4ekL4K79zOQ9gDj7FFotlqtdB0nY2u06MvyDZaYCkJiNzy1K6sUMY6P8SPAwZz2xVPxw7BtkM/v+g8MIdAuvEL3gH8T7/8P+DQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YbsDVA9/JrD0EyAAhFdgGm3Q4z9exxNDc6csx/HFPig=;
 b=R8iBBXdFt9NQg+7BhWktaRZxQugMeuHsB/vfuX/mHxuKek2OzPbvWjT7teo7722D4AK13R58qrEFdPJhjOK3QyBT/J5MBCAADOCfCoDyY94DU4T99Lxh1NriX/MKl/VcmpQcLUHq7J/L5iOqFndBJW5FujyGxFMsH2324wR0MpQ=
Received: from BYAPR10MB3366.namprd10.prod.outlook.com (2603:10b6:a03:14f::25)
 by SA2PR10MB4602.namprd10.prod.outlook.com (2603:10b6:806:f8::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.18; Fri, 21 Feb
 2025 17:53:18 +0000
Received: from BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9]) by BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9%5]) with mapi id 15.20.8466.015; Fri, 21 Feb 2025
 17:53:18 +0000
Date: Fri, 21 Feb 2025 17:53:16 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Jeff Johnson <jeff.johnson@oss.qualcomm.com>,
        Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-staging@lists.linux.dev
Subject: Re: [PATCH] fbtft: Remove access to page->index
Message-ID: <27cc53b9-0db7-451c-9136-5fdcf42145f7@lucifer.local>
References: <20250221173131.3470667-1-willy@infradead.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250221173131.3470667-1-willy@infradead.org>
X-ClientProxiedBy: LO4P302CA0035.GBRP302.PROD.OUTLOOK.COM
 (2603:10a6:600:317::11) To BYAPR10MB3366.namprd10.prod.outlook.com
 (2603:10b6:a03:14f::25)
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB3366:EE_|SA2PR10MB4602:EE_
X-MS-Office365-Filtering-Correlation-Id: d9d05ee5-393d-43e6-9084-08dd52a09fda
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Ws5PnT2e6wJKmjbbjc2saSf2eWDpRyLclpGWnUFc9uYD42eRJlYwtgZg67wP?=
 =?us-ascii?Q?jK5gz2Yd9qlgYuc90BidVwpGcAjlwoY+wFfa3ztWJNZ8y5a4JZ+dGxi1ZdEc?=
 =?us-ascii?Q?peo2fQ6zK/SKl/1+zNQY4ljdB9MvQYsBAmEyH7e23NnMpbVOJxmSJ8RlSaFO?=
 =?us-ascii?Q?Ua/x/WGyTj4+BcjkhopHmvBHwll00lpXUYtSbJrfo4iI00d92Nxp5n9hAtwI?=
 =?us-ascii?Q?vzBe8iCQaLCjMpRvikUiK3NTXbpZVyqjQIM6zsQK0IslCkPhVNdIswC6utd6?=
 =?us-ascii?Q?NaxroWjhsg3JBD8og8ojUHN39dvZK/ysW1M1HU+rOS6qC+AfZqpsmhmC2tCV?=
 =?us-ascii?Q?J83hITC9+wY8EyXJT93s9tFXuP2Rl/vLj8Qi0xBhZZ7+gNZqW0LCoCr0vgcc?=
 =?us-ascii?Q?Mn0zTzhIW/PCE2ro7Zs5ocCmfgYgRg/0aF1SLr0fw2O5ivjdlW85p7hb2j/F?=
 =?us-ascii?Q?T7pc3MF+MBhl0TRIMuPPR/glkMQI/O8Gr05MVi9CIglUhjm+1iGNr1g79Fu0?=
 =?us-ascii?Q?mfpzpCTsnkEShi4Fc4R420pzhnuBPKrMHwbOwsXigK5b6IfgCjqu6aoR1e81?=
 =?us-ascii?Q?inGDZWebR3POgD0f+eLDWwK0xSr5cRz58L5IPqa5EdLq1UZN9HNYRzpQkzZj?=
 =?us-ascii?Q?X3JO944YB9NKGsDaot1Fgw+HQs4j9WodvG/1mJ0s//zur851v7lYC1n9HDqF?=
 =?us-ascii?Q?6vZuAADAcEh+jauGVXVQO3uAWvFx8Qvn5l9fBY1KxQSF7VmA6rqGdiZJF2wQ?=
 =?us-ascii?Q?m7SROlF5FNbZkl3jLGEU8qsafK/erUKklAVeNT7YiGqJJEY+dIU5jg9JGSiB?=
 =?us-ascii?Q?APwCNIxtdL1YWagqdv6UqfQkjKp+uvLqCtup9/od1ecjBmh+AwRqZ9nMit2J?=
 =?us-ascii?Q?wCxV5ldUJj3APVpi/gYjwYcqtpSQjobovG1YQta8nFf3nT8V5f3alQyr/3+u?=
 =?us-ascii?Q?HJt+bzG3zvWsGOol9dyq0056UmniRhAZ1zzfOcxdAqpIIoq1yL1ZU7ZY80Vi?=
 =?us-ascii?Q?Fp2n5JNIBRASIgpLwoBfrXkMxp7wmbn6lywfGMdQSTvKPym3xwrSFXJcqhqf?=
 =?us-ascii?Q?RDt9LwZPDZinO5PW1I2DXXZxyFI5D8Eof4ht6rmA5ZnG2gnKcH9j+72ta+cK?=
 =?us-ascii?Q?lcfXjwq+/VXr6NwDorsmaeZnKPuundX3wpTSsNlYvEwngelGrmKBUhQPU3X7?=
 =?us-ascii?Q?hb3OhNeOX/r3Ugjq1tyrnrIWjd3FwUjq1w++wAUgajPvvLyaYnkBZR171ckq?=
 =?us-ascii?Q?V5CiydFUEB6wddylpyz1MVtEA1yBbXb/YqcTFdTdULSh/TsOg+z4WDOHCFRu?=
 =?us-ascii?Q?gh/Uu6t9BCcvx1C6poOEoEgP7DxFQrsjWNx0gWU4CXGqlNbMF94gesMTYU6j?=
 =?us-ascii?Q?2YpKXoxNaE4qDHm/eGQrDRe2Xb2g?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3366.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?G/7Y+y5J7B8V/rbQuPavqQtugQwHZLuRmxhaMRKwuRKI9har2upLH0GT+6Tv?=
 =?us-ascii?Q?DaZBQ7tLGMvLGuIBMGAEgyCjn0b6rQM3AeQoHfEO9qBjzw2MCk5Dpnz/x4EC?=
 =?us-ascii?Q?3zhlUwSMHk1ufUH1yrcsW2hPImTeq8CiJD6tX+IeVRVTt1z1lQYaYKWc0RVc?=
 =?us-ascii?Q?UCGeku6bDQQSZB5XLF8etujE6BlCnnwjJxvOIzYGn9HD2rvjey5aQEhgCHn1?=
 =?us-ascii?Q?CQTx5e9xb30d7Zug67J8mWk7HFtMV43Ndd2EWJoWACLBNic/Sxt22anmdR+y?=
 =?us-ascii?Q?AOnOT1B8dCYx6C2tkv+fTgz9mU7vpxMzpJZcRZjDfDOxgoqI2GqNtxbuU5pU?=
 =?us-ascii?Q?LUxDTWzDo8P0VAf18r0mxIJFA3go3DyokyGcavags/Vjymf4s5AlBCh/3Miy?=
 =?us-ascii?Q?fC1ZpCgmYJzOx05VGlS5rHDZMxj90vLOQsxQ4RMznQOHVdT6exi9OWSWKsWB?=
 =?us-ascii?Q?Kvjw5XVwp750j59zz/EV5gMaE9m0Ifc+r2NAZVUd7kA8QIS63hglJqKQqfap?=
 =?us-ascii?Q?amRjxWTJ3SdDmZCaB1fQ0NjX040wehAhNP1Vf15bR9vDxR/a5lR5yKho7Zt8?=
 =?us-ascii?Q?Yl7++0RJjgxh9MYsU9GxwnYfJxBS6f7jYkNuQYF97xUTRI14Yt+/NE3TTH8V?=
 =?us-ascii?Q?8P0nWIMAxgrR5m3nywqDHaescidncTr92r9iu69fOCs9aWciUR9BmMXX+ejX?=
 =?us-ascii?Q?7b44YKrndqTR0r408LCwJ0Hv9/y/f+loqObJ9wyLX2elUiwA4IPweX19Znqe?=
 =?us-ascii?Q?oy44n7ry24g2og8YXWoziNTTtzEeX1xghJUMQXTdVQpYi1+TP8FlnVFzCvtc?=
 =?us-ascii?Q?5RywPpLz7zmWWtPAa2rnxd8hhUIrM+EHYh3b0w+wsiobunkpEJQoVQJ/Pppu?=
 =?us-ascii?Q?dcGoFJtgDjiwcubCLlnSgF5p9I16FDV41r/k1ylg0WsFV/D9/4eQpMuKjr4r?=
 =?us-ascii?Q?q90ayI3TItyzEP5H6WMIMBbCegeww02iRrnzaflLnzmid8uJrRNvwH4NTp2Y?=
 =?us-ascii?Q?DezJva9J9NBjsIHRhW67JFqMsUEaohCINtxFHR734pu8mGt2ghui6TusT1tl?=
 =?us-ascii?Q?lpPnkCvEC6mmgrWGuuIzCKua+SoxBj2z0WxoHNOJw2rSRv4QAEbVPftH72eH?=
 =?us-ascii?Q?2AB1nFU4zHgloFXDNVYOfz2WoJAWe6STJrih+fjFM8I0FPNRoAoT6KBKQmSm?=
 =?us-ascii?Q?2Exm+XvT42S52ok9opdOZ7E+ZxAYQttdSfvRQKPfVtzMk789ZitvjOu0S9UD?=
 =?us-ascii?Q?0Nkr3gvvj20r7DldiGE6sFd7sFLTAnvne8JOxRibbL8YrA7ycdmgdTRRMcJB?=
 =?us-ascii?Q?8pmXsqpzznaRcERP6SlrQaOkvog6mfuwIbtW0D1vZzGbK1fhsfE58KBnm+Qo?=
 =?us-ascii?Q?OLwWyqN9PGA2wr0MpZQe1fNS4sGw7vyasqiQOfCeN2FuBkk7YQRhGFXBHNr9?=
 =?us-ascii?Q?EqWl+1qG6YKua1w5OmRg/zxaxRQIs5p6cnqO7n4HGXHcopzh8WAMD9utzWZJ?=
 =?us-ascii?Q?OSN7DIbiUpWmdY1+sHdH06BGP+uTUBFXzJpLCKoBrxeO1wkIS/BfMnScYX1u?=
 =?us-ascii?Q?y015SS1ns9ATHBt0aQoH2xDVTjcJM0yiQT5I5Bi9b7ISAVTBDZLjHJ4tNcac?=
 =?us-ascii?Q?HA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	YokyOQ9QqsEcS0r1W7zHmCw1nZspusH1OIhEmW9cBbSHDjd8BJhLZiakDTlXCWcXhgPcIzqSIO5dobQVSAueM19YMxNmVpKQD97mK/HeDlnr01vSblr9MLeoR+CO7XjalWuslrpdac4231d6B+0yurAlUCiZH7ZMlgqMQynoD9C4kvX7NtSg6oAMZgekJdTDAC52bm7vDvhbYiXJqEjvtDXWHxqj6INbdhBDV91wU5mlGLt8JIWuXOMu4mRJHH6C4SRlxgh/FXSQwiPIRAFL5TosvPppw6mWnT9rx6CJc2z6tdEaf1w7RD2hgpF1kElJ8+stI0jAOx2L2jhzbHN5eV5zv9Zm9L87pXV6Kr9AZSkEWBzFbnzhceTWInaniStWgzD5p2+Nf82cIzmF0IRCco5wK/l299Eboqsx+kiy9ROEKgl3kHBGxXsSSJhGZaLuiNdn6vLaKeBG0gP2UMEisvCXTYQqyLV455oDrtOZ8LN12geCzOh1+xpMh5C8qL2g0ER6pHp3un1hKZAeu9rB8Dr1MUHCYK5AI8QxiLw3rPfVxh1gr3wOTEeMKEo/kmCYdOghSaSL7o2cBOR9ExVBD/MIjSinrTbQPbIn/0LrEnw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d9d05ee5-393d-43e6-9084-08dd52a09fda
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3366.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2025 17:53:18.7417
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sqTBWfTtg+q+jACMkcYEf9Rrg/HEfEllB2H3CTTziPRWUIcGrp/l3Buz18fHJCagMbXE+XMaDi0R6E2pTJRi3UBVkKtzTLdk1gFy9a6iTLs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4602
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-21_05,2025-02-20_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 malwarescore=0
 mlxscore=0 spamscore=0 phishscore=0 suspectscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502100000
 definitions=main-2502210124
X-Proofpoint-GUID: R2EQGcrUf4_u3FfmFXCtR2-X_ui-bqu5
X-Proofpoint-ORIG-GUID: R2EQGcrUf4_u3FfmFXCtR2-X_ui-bqu5

On Fri, Feb 21, 2025 at 05:31:29PM +0000, Matthew Wilcox (Oracle) wrote:
> There is no need to print out page->index as part of the debug message.
>
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>

LGTM from my side,

Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

> ---
>  drivers/staging/fbtft/fbtft-core.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
>
> diff --git a/drivers/staging/fbtft/fbtft-core.c b/drivers/staging/fbtft/fbtft-core.c
> index 4cfa494243b9..da9c64152a60 100644
> --- a/drivers/staging/fbtft/fbtft-core.c
> +++ b/drivers/staging/fbtft/fbtft-core.c
> @@ -337,9 +337,7 @@ static void fbtft_deferred_io(struct fb_info *info, struct list_head *pagereflis
>  	list_for_each_entry(pageref, pagereflist, list) {
>  		y_low = pageref->offset / info->fix.line_length;
>  		y_high = (pageref->offset + PAGE_SIZE - 1) / info->fix.line_length;
> -		dev_dbg(info->device,
> -			"page->index=%lu y_low=%d y_high=%d\n",
> -			pageref->page->index, y_low, y_high);
> +		dev_dbg(info->device, "y_low=%d y_high=%d\n", y_low, y_high);
>  		if (y_high > info->var.yres - 1)
>  			y_high = info->var.yres - 1;
>  		if (y_low < dirty_lines_start)
> --
> 2.47.2
>
