Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012041.outbound.protection.outlook.com [40.107.200.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D88B22C158D;
	Thu, 12 Mar 2026 06:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773297435; cv=fail; b=KUqwa0skd70MvHtnQ7nIFgnTduGWwhTV0qJ/LniNI4x6l5fiJrzvfA70k+20unoInmYcH1wD2jcfVigbtyRMVmHmj2xdJ086B+qsY+5Oncj8fhkkNKu2zvc3yrvIDg9yOe4RnLi/DA6foQiD4yhxJs+MtZdI2Gm3HfOTGuSB3B4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773297435; c=relaxed/simple;
	bh=EdYUxMPHeL0iiSXwm/WmKBGQENEFKhpSYUourzdcUHA=;
	h=Content-Type:Date:Message-Id:From:To:Cc:Subject:References:
	 In-Reply-To:MIME-Version; b=KQiCP4XDYqHa9Nw4IPcyyE/Dh1LxK3Oe19E0PzezjypCKjkYS+/ihdcprk+TVaM3So0ONcbHGfRw8hmrit3fXTA1E4xihXI7UdYUPxQ+ZQQCXSEZD4axJlIs5tRwlGTVQUV0LpasgWWP9PEyTVFRZhXNUY8dhE48/19N7L6uq9A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=l2/EYMUA; arc=fail smtp.client-ip=40.107.200.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="l2/EYMUA"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C8W2d305DCaVNL5pbxlteU3XLWwEx3GxMQWyRXTJfAEGgaQp2Erh4ZLE3wKsHml1qGFujtXF5a2H6PKwhsEoZ2r6IPZlhBup0n7j1OXOxnorYALma2ze+pq19x3GMNX4tWhUKbPs2zU6EHq25KTtMumKUFg++RJxIAQnyRtCWFCDLR2PfyDkiGH8rZ6oaZC/xABYZ9JSkAS+tc5/QjkBPQv2WV9HGmxps+fKV41JkdXr0J/gMiMJrF4P3MFjCHmy7ti14WY+34gKROWbT7E0LLG7KG+2g1nccluDhLRYD8ZpQ0mCgAPHXR4VQ9DZjAeoquFxEZNDHCW0O4gr1w8VeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zNLCkufJkz2VjpSG9SWnzHgKOyxNp94PJP2xxijIU/A=;
 b=dgi8LdC1mWACbzw1H+hbZErEluF3DcZbFlkl9hAoIXmMTD557+jAKnuC41KbfKVVGAuJsWnusrA/eudf9No8LVHAOMLNpH39ZONIRPjmF2RotiDSYZbyeB6bxoF0TjBds9g7tnrieFyd/ElTb+5cuwj8nce3ZiNs5SPzX1xkYK4LUjdwbeTNrA+6+YhyN8EqAKM+ycQHxRxdBZ7mSmuuQpIS87gd+jTJ01WufkdBqS2+TwMDcuaZtYJ7OF03KgUaYGQulAoN10Q8X/hlymUHOMHYftDgb5CVSDYJFkyRgsIR0utng7VzOUxKi1fB9sv62jrTJ83P1BHRFvRKrWil6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zNLCkufJkz2VjpSG9SWnzHgKOyxNp94PJP2xxijIU/A=;
 b=l2/EYMUAjj+LCVor01xXiXviD3VRC8pSI8WBPj7lErjTpP+V0dRBdmzws3qG1Q9s7yRWapi+nFj0QmbK272i5kpuTxQ5hx3x6s0FFJQg6oqQogtWJx7gdtQAKJNyyZZuFiuN6B+6vUDj3cbFp35/Q4+MdMuW+eVaUCh8eEoxqspA+PtIPfx1qa8swMCKCqv0ZGh+jhOrtXVCZZC2MoE15YnwrQK6Fg35aUbmCDAw7FSIhvqDWaEwaFN72gjz/2lWNW57DSsA2/UpNZyQc+2gpmuP+4aemghDK16oVds4Z2TRVoq7EX8D5QJFMkf2J96Hs3l3URb+1ph3u62KtuCdxg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2353.namprd12.prod.outlook.com (2603:10b6:207:4c::31)
 by IA1PR12MB6555.namprd12.prod.outlook.com (2603:10b6:208:3a1::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.4; Thu, 12 Mar
 2026 06:37:09 +0000
Received: from BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0]) by BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0%4]) with mapi id 15.20.9723.000; Thu, 12 Mar 2026
 06:37:09 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 12 Mar 2026 15:37:06 +0900
Message-Id: <DH0LH3D38CZ1.2DK8BN4CMU4FW@nvidia.com>
From: "Eliot Courtney" <ecourtney@nvidia.com>
To: "Joel Fernandes" <joelagnelf@nvidia.com>, <linux-kernel@vger.kernel.org>
Cc: "Miguel Ojeda" <ojeda@kernel.org>, "Boqun Feng" <boqun@kernel.org>,
 "Gary Guo" <gary@garyguo.net>, =?utf-8?q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, "Benno Lossin" <lossin@kernel.org>, "Andreas
 Hindborg" <a.hindborg@kernel.org>, "Alice Ryhl" <aliceryhl@google.com>,
 "Trevor Gross" <tmgross@umich.edu>, "Danilo Krummrich" <dakr@kernel.org>,
 "Dave Airlie" <airlied@redhat.com>, "Daniel Almeida"
 <daniel.almeida@collabora.com>, "Koen Koning"
 <koen.koning@linux.intel.com>, <dri-devel@lists.freedesktop.org>,
 <nouveau@lists.freedesktop.org>, <rust-for-linux@vger.kernel.org>, "Nikola
 Djukic" <ndjukic@nvidia.com>, "Maarten Lankhorst"
 <maarten.lankhorst@linux.intel.com>, "Maxime Ripard" <mripard@kernel.org>,
 "Thomas Zimmermann" <tzimmermann@suse.de>, "David Airlie"
 <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>, "Jonathan Corbet"
 <corbet@lwn.net>, "Alex Deucher" <alexander.deucher@amd.com>,
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, "Jani Nikula"
 <jani.nikula@linux.intel.com>, "Joonas Lahtinen"
 <joonas.lahtinen@linux.intel.com>, "Rodrigo Vivi" <rodrigo.vivi@intel.com>,
 "Tvrtko Ursulin" <tursulin@ursulin.net>, "Huang Rui" <ray.huang@amd.com>,
 "Matthew Auld" <matthew.auld@intel.com>, "Matthew Brost"
 <matthew.brost@intel.com>, "Lucas De Marchi" <lucas.demarchi@intel.com>,
 =?utf-8?q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 "Helge Deller" <deller@gmx.de>, "Alex Gaynor" <alex.gaynor@gmail.com>,
 "Boqun Feng" <boqun.feng@gmail.com>, "John Hubbard" <jhubbard@nvidia.com>,
 "Alistair Popple" <apopple@nvidia.com>, "Timur Tabi" <ttabi@nvidia.com>,
 "Edwin Peer" <epeer@nvidia.com>, "Alexandre Courbot" <acourbot@nvidia.com>,
 "Andrea Righi" <arighi@nvidia.com>, "Andy Ritger" <aritger@nvidia.com>,
 "Zhi Wang" <zhiw@nvidia.com>, "Balbir Singh" <balbirs@nvidia.com>, "Philipp
 Stanner" <phasta@kernel.org>, "Elle Rhumsaa" <elle@weathered-steel.dev>,
 <alexeyi@nvidia.com>, "Eliot Courtney" <ecourtney@nvidia.com>,
 <joel@joelfernandes.org>, <linux-doc@vger.kernel.org>,
 <amd-gfx@lists.freedesktop.org>, <intel-gfx@lists.freedesktop.org>,
 <intel-xe@lists.freedesktop.org>, <linux-fbdev@vger.kernel.org>,
 "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
Subject: Re: [PATCH v9 03/23] gpu: nova-core: gsp: Return GspStaticInfo from
 boot()
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260311004008.2208806-1-joelagnelf@nvidia.com>
 <20260311004008.2208806-4-joelagnelf@nvidia.com>
In-Reply-To: <20260311004008.2208806-4-joelagnelf@nvidia.com>
X-ClientProxiedBy: DM5PR07CA0073.namprd07.prod.outlook.com
 (2603:10b6:4:ad::38) To BL0PR12MB2353.namprd12.prod.outlook.com
 (2603:10b6:207:4c::31)
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2353:EE_|IA1PR12MB6555:EE_
X-MS-Office365-Filtering-Correlation-Id: a4ce3905-66c9-44cf-d792-08de8001c8f1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|10070799003|376014|7416014|1800799024|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	4j0YMQPgrGbfQj6hQZ+tsh7VXPVQ3I643CsYYu7ZkSQj941M6iFKK9Nm4CMc8PsE4F7lPk9GxcrjKga06Frf8JNQqvoMhhy//wZQcHR5XPfPFLbGBGqRUSgSBBeL9h/h60puOtVr0ApCYoCxh36nS9KpWSHvhZ3y9sFA2hQHAhnn10nfGwFLczVbl+ZzJ+UgMk85RNLxlOmD0y8trBPFZWFf4cQ1fkjYOEcgzh+Urt12UeZZVdn9TqJVV+fGVjIinR4tcnG/2u+8WNrp31ok7DwxpIJqRIy4jqJS6CJa9F28/pReqXXPXlWtZ3CkJJ/IY1kwDJtSa/wMWgrp6ykzk/hy27EpfnbfmjXZ4nbnUg/YvbwbYECecIni70bn8MARdWlq4EAu2Nz3gliCTTBjYTzmV7wjeroC6YG9wdgQ/0JlhxcJ9jlKMayhr1NsDt/kvzNv7i3yZmmWg0ayLPoxDPlPZen3RrWFa82evpJwBS21TdqnRqpbT18/rYW2uOz3MEtYoOzDTR2jQmg+gw6ZNo20nJQCndMfcsvXNvJdrf6A4tifXerAvplBls/NNALzGb+smKRoqirtc9ZvFKCfA4OPR59zcroK0fXbvsnlxuwYpjnD3XVsXsHYd4t3oG908R4y6e44HOYA9gDB0we1BTWf7Ywbu3dcdKGzmO8+4VM1G/UXuQVumOuZJiaS3TOD4PqYHgeIAjq3zJC239RIorO3hC5MxgzojCcGVXFZucA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB2353.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(10070799003)(376014)(7416014)(1800799024)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TEhNR2hXbFZCWXltZ0ErVHZWYXBSbkZncGEzOHlZZEdCUUcyM1ZJVWNXZmRs?=
 =?utf-8?B?NHMxZmVUUW9aNnBLeCtwNHA0M0ozS3VEWkRNb29FRmV5V1plVEpPMU1BVmF0?=
 =?utf-8?B?b3RndXJtNy83L1hCMUlYUlIwamorQ3pEKzFES0J3VUhUcWpwSjFvQ0pDS0xP?=
 =?utf-8?B?TTFiYjFFVS90QTFvUEpUNWlZeloveTRVR1hUVWhnR1hYOGQ2ZUNJZUhFMkJK?=
 =?utf-8?B?aTd6TzE4a3QxYmZCemprdXhNOE5PMjJsQmNUQmVrcWh2LzZ4NXhQb1BxanNs?=
 =?utf-8?B?d3NBOVFwekh2SVdsTXhTbWdyd3lGV2FzdVNCWFYrRkthMmtJNkc3QkNacW5V?=
 =?utf-8?B?UjhpaHRxTXBySVRGNDR3UlZmT09BRVBSczEwT1pnaWI4RHAxV0s2Z1dQaGtm?=
 =?utf-8?B?UmhBTzFYcFhtczZPWEtZSUEzc3ViUTEwaFFnRTh2VjJaNjRBay9lMXJ0QTFD?=
 =?utf-8?B?T3RmUy9lS2FpNVJtTFJzM0RhNjVHK3FOY1pncU9KSEhRLytTd1M1ckt4SVZy?=
 =?utf-8?B?RnlDRG8wekRFaFBpL0FEUEhJUXJYUkx3TUlmSHR3TzZmbE1ZQ1FyWk55TXdR?=
 =?utf-8?B?WnZpSDNmVlJhYjc3eUQ0bUM1YkY0dVlDM2oxMFprdFRTOHFOQ1NKbmlLQnBE?=
 =?utf-8?B?K2V4cnRwVlNtWmErY3ZQRFRvai9nWmRNd1ZGb2l3ZFh2Z3lvQTRETS9wS1pC?=
 =?utf-8?B?cE5VYUlYeXRRLzAwWDF6NkcvQzdoc2JsR2lIZGdNWk9rRTZvN3FyUUQrcTRO?=
 =?utf-8?B?Z3ZsOFFITmhrdmF5TjZuREFqRU94SUFROHFxbWt5TlVCS1A5N3hjWTdmNVJC?=
 =?utf-8?B?WVFmbHEwWHpZZ3Ntdit5TERLZnVpVTNSTW81c0VBZGdoOElyUmViVUFNS2VI?=
 =?utf-8?B?RGtRQytXOUQ2SDdHNUhIYWJSRnFRNmRQU0psSVRZRzFxVjluWnNQallhR3Fq?=
 =?utf-8?B?QUREbGlPTGt2SFBHbDlBczhwU25sTVdHRWhhUWJXU01JRVBYanBvMndUQm13?=
 =?utf-8?B?ditHaU1iZlJmdkIvOUFIeDJGK1lMWG5lOXM0QnNmMTJVcEFtcmI5Q25iOGJ1?=
 =?utf-8?B?RDZyMzI4SnppblJUMGlDTWU3VFRLTlNMVWN1ZkpUbm94QWQ0WmdiT1B5RTl1?=
 =?utf-8?B?TmVucG5WblV5eDJ0ZFFFbUNGcEx6LzVaYUgyN1NXNmxTWXlwT1JBeVNad1NM?=
 =?utf-8?B?aFFSUkdoeUdGck9IT3BnTU1XU3BocXZtMkdQMUlsQ2FZNEFYQlM4RVJkSEtM?=
 =?utf-8?B?K2RGemFKWExRRlhVQXFkbkRkYjlJV01rWkY2RTVSbll2TndhMkl4cHRQemIv?=
 =?utf-8?B?SDVLcmdzNHVBS2E4SFR0WkROWXhZQ0d1Zk5FSmkyM2Z0MzdwMldTZW44ZlNN?=
 =?utf-8?B?OUNtVGtDUVhsa3dGeElwcUl3c2lZeWgwRVhwanpJK1doOXlFSzVJSmdCc1U5?=
 =?utf-8?B?MTRleFlaZU15ckN6R2ZYNC9Ic1h1VWhDekJTZ1A2VEZJanZNeHpGYk0yTENV?=
 =?utf-8?B?dyt5SlZJeDdkYTZ4ankzL0pUTmNONHZzd3h4ZmlrRDZCSGZWRHlmZHNXSkVo?=
 =?utf-8?B?UHBHUHBMK3RwMFgwa3g1bTNKeWVheEhKT3BrQmlEVERvQUN0dWQ0WnBUKzQ0?=
 =?utf-8?B?UlRGdi9TeDFVcVc4azhKM2p5Ky90MW1SNzZCOHduSW1aWkNNQ1dValUrcnZI?=
 =?utf-8?B?Y2Q5OWZEdXArUFlXTTBhbzJza3hVKy8zbysrY3M1SXlYb2tvRFZyRVVQbnFz?=
 =?utf-8?B?bWlkTlpnQkJiVVl2UlpwemRVU3I1WFhrdTlRTDhpUU9zV21DaEcxVjU2dVZx?=
 =?utf-8?B?cVorSGM1cm95MWRWVTN5ZjlncEptTitVUEdGZjlzQ2N3K1U1QytrdGgzVk9s?=
 =?utf-8?B?RHVPdHNQSEVacDlMZ0ZtTzZxcGF2R0piVFNncDFrcWhIWE13cG9ibnlUbXZz?=
 =?utf-8?B?bDlieFlDeDYwSmUvOVJScG8yRnl5RHBNaCtMNnF0ek5wMDFZdEZURXdoRkt5?=
 =?utf-8?B?V2xUUVhaRHhkWFM3SGhRZzcwT0t5clJqRThRMkN3cUFWVVJXVUkzNmh3MGVS?=
 =?utf-8?B?Rldpa3pqTzdDRnl0VDlHSjA0ZGlvcHdwLzRpTFRyQWFiY292aTE2aVQyVjZS?=
 =?utf-8?B?cjNnZjF5b0lUVzQ5ZEZZc0szYjVLajdOVytVU3d2ZjZUTXFoeGJESUFTdUJO?=
 =?utf-8?B?cldLVnZyWTRzb3BILzNlSjBoek5WaEVtRXo1N3FKUGIrU291QU1xS0F6T2x1?=
 =?utf-8?B?YnVCK3gvM01CaFlnaGx0RE5XVTZsZ1ZKRkpyc2JKaXhmeHgzK0xHTlhDaXBo?=
 =?utf-8?B?aFRLd3ZPeVNGbGdxTjduYWJYLzQ2TzB1aFZXR0hNbGF2U1dXcmR1QVNtQlNw?=
 =?utf-8?Q?6ZrwvBykgpWUHVDd2+4B+Hx6A9+AaWEEEReMpNgGgncr0?=
X-MS-Exchange-AntiSpam-MessageData-1: moKIxnGmEgIkkw==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a4ce3905-66c9-44cf-d792-08de8001c8f1
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2353.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2026 06:37:08.9088
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IHkw0crg2oJLMhwaS3jJjOzg/Li3S+wGA++W9s5pv3fKWEu8ePE0qYL+G7pNRseqdeuWWRh111UGwO0G8n0Z0w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6555

On Wed Mar 11, 2026 at 9:39 AM JST, Joel Fernandes wrote:
> Refactor the GSP boot function to return only the GspStaticInfo,
> removing the FbLayout from the return tuple.

I think the commit message may need updating - `boot` doesn't return
FbLayout. And it returns `GetGspStaticInfoReply`, not `GspStaticInfo`.

Other than that,
Reviewed-by: Eliot Courtney <ecourtney@nvidia.com>

>
> @@ -126,7 +129,8 @@ fn run_fwsec_frts(
>      /// user-space, patching them with signatures, and building firmware=
-specific intricate data
>      /// structures that the GSP will use at runtime.
>      ///
> -    /// Upon return, the GSP is up and running, and its runtime object g=
iven as return value.
> +    /// Upon return, the GSP is up and running, and static GPU informati=
on is returned.
> +    ///
>      pub(crate) fn boot(
>          mut self: Pin<&mut Self>,
>          pdev: &pci::Device<device::Bound>,
> @@ -134,7 +138,7 @@ pub(crate) fn boot(
>          chipset: Chipset,
>          gsp_falcon: &Falcon<Gsp>,
>          sec2_falcon: &Falcon<Sec2>,
> -    ) -> Result {
> +    ) -> Result<GetGspStaticInfoReply> {
>          let dev =3D pdev.as_ref();
> =20
>          let bios =3D Vbios::new(dev, bar)?;
> @@ -225,6 +229,6 @@ pub(crate) fn boot(
>              Err(e) =3D> dev_warn!(pdev, "GPU name unavailable: {:?}\n", =
e),
>          }
> =20
> -        Ok(())
> +        Ok(info)
>      }
>  }

