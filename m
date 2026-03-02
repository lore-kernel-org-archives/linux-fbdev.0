Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012071.outbound.protection.outlook.com [40.93.195.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D38BF363C68;
	Mon,  2 Mar 2026 12:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772454239; cv=fail; b=AesK/flWV0UaDILbvEjv2TpTT2q9X3j0wv5TArBVpG1Ts3QJyh7lbGgQeG4gtE2+b1rtw5mcm/QgVz+W7mpgh2osPtAQ0RGQikmJ7YwgZnEbxdTCIiywvaex9r/AevRZ8EXywms03rUNQiM2EKK1TZtQjclY0+csd4QbWbCXXp4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772454239; c=relaxed/simple;
	bh=oRtM+8Vup8Ovrp94ZOUNbyMQq63e4kB6wKBui8gwLrA=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:References:
	 In-Reply-To:MIME-Version; b=a90qTy6VzCMKD0aD+f9D0coM706M6olKt+xFk5W4ezz/20EOPTcIe4z6dzx0d5lUuFukpZX2xn0nJiJqhw+XiDusxod7r63wZSRKlviyeUOFvEaKxrk11kPfo2B4y04J3R4KiBQRdhAb+PTqiL1xFGW7uobpbpZQv4VEcTi+TaQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=KBYMifQK; arc=fail smtp.client-ip=40.93.195.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="KBYMifQK"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZZqLfqh0Dh2ke4LPalcFGgGm0aB1ax2lD9f2lPQ/0K/1Og6d1YuwETkW4K2EA1rb4tSWU+utQ+1QQCDq8Rre58nWYYE+Fn12DsEKclK6lf+w42c3tcAOlBRnuRo0tV10frOq57tDKushRfAfztWm+ChiebjIwaKu/ZZi9IJzaalh2b6657dCDocvhzpvwtbGI2F9oz14Djb7CvdILQTtw8K6jw1L1NG8kokLXHeQU+3emV2j8u3dchXIJELlB+I6eOoWq6YFC904LQTxmXVTMfN+7h1w5Olbw8XQz/XLrwXJf0w59Cac8aUGd5rgUGpFyJjlqaxZEj2suwMjul53Pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oRtM+8Vup8Ovrp94ZOUNbyMQq63e4kB6wKBui8gwLrA=;
 b=sbUSsJe9jaL2QHcRQN4cItNIrht6Ud0DFDvdw86me7FbxrlvlnWDYLB/0cvEG2FFtKXa6nmnbSYur/1OljFc0N1RIpMUqyJ/m3ThBQWc5NnR4/M1kNyfMauh4yH9XYPECkrsz8LnV15A1xS1vfAmlPApQsXw0M82SG5JHEej2EIJqPqq14PdKJ5sEWolGugCvEynVHmBTOS2TYOSzpsT4U7ycCCUm06kWwKY6QZSb30X/3qsgkzTHDKpPK0YJC3PalB99qd6ANw4s2jbv8kifcVau7QQhE9k8JyVDkq1anenGm3Uy/hCndrMppdqVmhuwaPFwNahJ7aQbVu3uEIJtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oRtM+8Vup8Ovrp94ZOUNbyMQq63e4kB6wKBui8gwLrA=;
 b=KBYMifQKiQUyS/uzsRM7y1okb4C5Z0nEhs1fn5+gZVH+U8y88NJjWtECL3mPjMb52XLPRhPnltitbg3crqqO7XaKbp6WXSpghzonD3zDNHB/yOee1zrhYn/unzrix9eaDYDO3Q7dP8bmoi5uVQ3guoWTfkAK+GZLwOQOCvqGawjvV9Aa135kHkOhnhn6WY+wr8nFY8QkHMN5a4zJG86+Lm7Sfk+HCRYb966yAaPePG9Ant0QWIAsrM2Th1cEieWXpMD4UOHcrYRvmtxRUgA5QjILSskTdIVD19KwT17j+TVSun8FR77lOazReOjk59ZpSAyGCbfJLSu+IaT233UFvQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by CH3PR12MB8511.namprd12.prod.outlook.com (2603:10b6:610:15c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.20; Mon, 2 Mar
 2026 12:23:47 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%6]) with mapi id 15.20.9654.020; Mon, 2 Mar 2026
 12:23:47 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 02 Mar 2026 21:23:43 +0900
Message-Id: <DGSAL1J55O3B.2LYEQ5VAIEM62@nvidia.com>
Cc: <linux-kernel@vger.kernel.org>, "Miguel Ojeda" <ojeda@kernel.org>,
 "Boqun Feng" <boqun@kernel.org>, "Gary Guo" <gary@garyguo.net>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Benno Lossin"
 <lossin@kernel.org>, "Andreas Hindborg" <a.hindborg@kernel.org>, "Alice
 Ryhl" <aliceryhl@google.com>, "Trevor Gross" <tmgross@umich.edu>, "Danilo
 Krummrich" <dakr@kernel.org>, "Dave Airlie" <airlied@redhat.com>, "Daniel
 Almeida" <daniel.almeida@collabora.com>, "Koen Koning"
 <koen.koning@linux.intel.com>, <dri-devel@lists.freedesktop.org>,
 <nouveau@lists.freedesktop.org>, <rust-for-linux@vger.kernel.org>, "Nikola
 Djukic" <ndjukic@nvidia.com>, "Maarten Lankhorst"
 <maarten.lankhorst@linux.intel.com>, "Maxime Ripard" <mripard@kernel.org>,
 "Simona Vetter" <simona@ffwll.ch>, "Jonathan Corbet" <corbet@lwn.net>,
 "Alex Deucher" <alexander.deucher@amd.com>,
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, "Jani Nikula"
 <jani.nikula@linux.intel.com>, "Joonas Lahtinen"
 <joonas.lahtinen@linux.intel.com>, "Rodrigo Vivi" <rodrigo.vivi@intel.com>,
 "Tvrtko Ursulin" <tursulin@ursulin.net>, "Huang Rui" <ray.huang@amd.com>,
 "Matthew Auld" <matthew.auld@intel.com>, "Matthew Brost"
 <matthew.brost@intel.com>, "Lucas De Marchi" <lucas.demarchi@intel.com>,
 =?utf-8?q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 "Helge Deller" <deller@gmx.de>, "Alex Gaynor" <alex.gaynor@gmail.com>,
 "Boqun Feng" <boqun.feng@gmail.com>, "Alistair Popple"
 <apopple@nvidia.com>, "Andrea Righi" <arighi@nvidia.com>, "Zhi Wang"
 <zhiw@nvidia.com>, "Philipp Stanner" <phasta@kernel.org>, "Elle Rhumsaa"
 <elle@weathered-steel.dev>, <alexeyi@nvidia.com>, "Eliot Courtney"
 <ecourtney@nvidia.com>, <joel@joelfernandes.org>,
 <linux-doc@vger.kernel.org>, <amd-gfx@lists.freedesktop.org>,
 <intel-gfx@lists.freedesktop.org>, <intel-xe@lists.freedesktop.org>,
 <linux-fbdev@vger.kernel.org>
Subject: Re: [PATCH v8 06/25] gpu: nova-core: mm: Add support to use PRAMIN
 windows to write to VRAM
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "Joel Fernandes" <joelagnelf@nvidia.com>, "Zhi Wang" <zhiw@nvidia.com>,
 "Danilo Krummrich" <dakr@kernel.org>, "Gary Guo" <gary@kernel.org>
References: <20260224225323.3312204-1-joelagnelf@nvidia.com>
 <20260224225323.3312204-7-joelagnelf@nvidia.com>
In-Reply-To: <20260224225323.3312204-7-joelagnelf@nvidia.com>
X-ClientProxiedBy: TYCP286CA0334.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:38e::12) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|CH3PR12MB8511:EE_
X-MS-Office365-Filtering-Correlation-Id: aaffaedc-08d0-4123-c2fe-08de78568d88
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|10070799003|366016;
X-Microsoft-Antispam-Message-Info:
	O9Vszd3hFXnRMtYA2KiwlJm7rUjYorWk1SJnJXdsFVg3FgQj51EfjfigW6uiF9T+T9iRZFKsq1ienvggAgtzVof9vXzDI7ZciCf7rFu2prrKvBLSqwiNPaZ+sv0Bn3VyviOSvTWigNol4hZB/6IQXpc1HWnlwhXCJUT8EYtRJsncnusRoUnuns/J1Xpjoenslig+Vk9/FFERsWWmuillwKa7i78aF6pJQUyRgQ5ZVPAakx6KiIb/znGYCeda3jTFPQt9n0zEOc87dS5DX58c6pN3zI9bCuKbpmn0Wf5QHhYePP79vRzcotpNX8Sc1LsBdkCHqVVamERrqPvMlnpFszSTZ0loDpnZA8O+az5/+qy2W1RUgfT1QQBiTWby9I3s6kwAcjbFi0rlHMHNbysNzm7eVfRiM40wcZPSB/xFGh9ITjjK1OHq/WjQ1ibRz/NU97FDqXDrzD2vgide8h01rdU3JPdrMOm0UnfhjoFmXNLKfV3DOCw/dBlC05L1cB8kRlW6/nke7h/rdoWPdqyfxYZ65S4BtWM3dXBoLbUvAOK96JrDuKbaWZEXJBxsC4EMyBA/H/JPo1XxNiAYkTXI4zWjFHNTAce3ilZR3sOuco2YYxe2w8MivzGmExNXmUSNOTD7yIwMm3Mo5IN2sJoYIFhAMG9wgm4iyDOnU49KX6k/6zvmSDzwxy5Ifro6acKKKOvhc8DAdTsUp4Zrs3KUF/+V13SosMJaw587jw7wiy8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB3990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(10070799003)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MHRWYVM2d1dGQVVlL3VVSW92RGNZSG9JSnh0eDgyK3ZBZ3BsRVk4TU5LaUNW?=
 =?utf-8?B?aysrQ083SFRMSHRxdkM1bldyK0pIaURqZzF0cXlVT1J5RWtVWGluYkhxR3R5?=
 =?utf-8?B?N2RhTnZMb0NmU0lDeUFxd0o4UXBPdThaZ2tRS0RtQld4YU1wZ3AzTjhhTUpU?=
 =?utf-8?B?RjFuT1V3cm1HOGtGQ2VMdXlPL0VGaFBXaGRBSzRhN2luYjFTUmdXWWorUDE2?=
 =?utf-8?B?bVkrMlR6WFN5WHJVT2VabkwyU0NqT0ROUHA3SnBNQUx1U3FHN3locExLUlNx?=
 =?utf-8?B?bVJqcUlDWTdUbzAxQmlWVFJpYWxWVUpEWWlIM2pwbUZpODF2MGxSVERINzE5?=
 =?utf-8?B?ektVdnVrV21PL05GVk0yZExMYVBEeTM3UEY0LzRnTnlXbGJONmRrcm4xcXp0?=
 =?utf-8?B?cC95N2w2RlB5enc3a1BLU3E1U2orVUZWejU5WUhsWG53ek1sTlBId3I3S3U2?=
 =?utf-8?B?RHA1L0UyRGg5MWd5QU40VWs5QTIyNVFhblV1YVN1UVZmM3VMM09MZy9KNEFQ?=
 =?utf-8?B?VWtZanNORVRkUHl1QkU0K2h0QUpETlIvRXRFOVp0Y2Q1VmpKT1l6V2VLbUdD?=
 =?utf-8?B?QkJmekg3VHExZnROQkNtL29zVmhKcEFNcFBiVUdZU0tXcDVjaGhKeThDc1F0?=
 =?utf-8?B?L0pvSG00MnZSZlhLVS9MdUtwT25ZM3c5dXlTUXlqdmNnUHhsZWxmcmxvSE9N?=
 =?utf-8?B?emZDdzBEZk1pelJSWFl1YUJvNlVYeDRlNlNpbUxCRkZyRm41TG9XN1FLTE9D?=
 =?utf-8?B?OWJnd0E1T2QzZDdpOHZVVkNFQVovNFpSQ0ZlQVh6dy9TS2R3NDZNM3dVcDRG?=
 =?utf-8?B?Y1VNTTR5SFI0RXRLcDF2Z0tCUzg5dFdjUWtuVCtRaVcwWHZNY2EzYzlTRHlL?=
 =?utf-8?B?RGxVbVlLU0FTVHUvWXd0U0pEUkxvNWhkV3oya0xsVjN2MVJyOVNzekErRDJr?=
 =?utf-8?B?Vno4RHJyNkpYQThKSFFZbFdRUVJ4Wkg4K0FrUXZkaStWT3FNTGJrdnROeFQy?=
 =?utf-8?B?M3FRb0R4L1NrQU9oVDJVUXNSOFhKcWFoK3FwTzcwUzczbVRKUkVJbTJXUy9y?=
 =?utf-8?B?R242b2g3TnNPZ2tKZDByTCtBOGFGUnFIMi91VndrekR1blNrZU8wSnA1dFZv?=
 =?utf-8?B?K0RXODlmTC9Za2c1dkJDWjlPNVMxSHZyWEFBeDFxYUlhUWtnV01heTZYRzc1?=
 =?utf-8?B?NHBxZE1HaTk0OTRVYjlMbWFoVEdXOGcyV2tOZ2pzc2Y2eUl4SkdDYmRYMzIr?=
 =?utf-8?B?ZHNqWVplN1JSVGQvYXZlSUZYUm9reHJ4Y3RSZTBJeFRma09BZWZ1cHF2Vnpw?=
 =?utf-8?B?QlcxOGgzL09sT1hQa3RDbUpSQVNXVjFuMVBnTnU4Rkc2ZTVVclB1VDl6N3Fr?=
 =?utf-8?B?eEd3UUpmajFGTkVIdEVtQnlpa1NCdjlhb2ZIRXVpZnZZV2lRU3d6LzlUR1VL?=
 =?utf-8?B?ZmhuVFVXNkRJR2RsM2tDS3lmOU5BamQ3ZUdzTEp0aXMxUklxRENqL01PZXd0?=
 =?utf-8?B?YllJbFhzT01ZZzRjZFMwWkk2d2ZROVExVStxWEFNOHQzVHlGMTBySFAwcmV3?=
 =?utf-8?B?MTl4Yjlia2FTcWZkekZheXd5ZVRKSURseW13VG5jK1VNa2NBN2FLczVyVU0v?=
 =?utf-8?B?YTUwU3FuMmdTUkV0NlRmajVoYk03cFozT0RPQkc2bXE4WUlmcXJMWlMwZFhN?=
 =?utf-8?B?NlpaZE43QUZqME80M2dSQkUrVjBPWU9QL0d0SnpMZmxVV1hhWU13OGhUWnJP?=
 =?utf-8?B?eUpSNWw5UVFxK1djdVk2MlhBeFFpN1dnUllzZlY2bkEzVkJ3REZRUE5YZjB6?=
 =?utf-8?B?alMvM2dNbm1aTmUxRWYzSi9qY1lYemNFVlJUQmw1S3ZnQnJZVGJ5bGwrRUxh?=
 =?utf-8?B?SmQ2WGlhWWJKSTF5UmpvV0hpOWZkWGtON1VPWUM5Qnl5ekI3RHBLTnhPK2xG?=
 =?utf-8?B?czFHeG1zVnF5S2poUkU2d1FDR2c4M1ZHMVB0V2I2Ky9VQ0h2Q0Y2aHgrYlFI?=
 =?utf-8?B?MGt2SzZyZ1drTGRsV2c5YitUcjZ6RWd1QmRva1pWaDVhekxScnRzamlCRnp1?=
 =?utf-8?B?NHlXVTZTaHl2N2JyYmwvNm85aWtLUUdWL21mOStnckxwdzh6aHhaRWVoQ3cv?=
 =?utf-8?B?YWNmc01kMkRYdGFGbTNoZlF5ZjlaSTN3UzFJRll1TnpBdUsyTmFLRTBQRytQ?=
 =?utf-8?B?SFpBU0M1aThNTDQ1b1o0VWd5Vm43aVhQb3ZxR1ZyUkZQbTdTeHlnamUrSFpM?=
 =?utf-8?B?U0hhRDVkWTRaQVdkQU1jS1NWYlJkNzFpMGtsWEFpUy91K0JOcWY2U0grM0s2?=
 =?utf-8?B?S0MwbHlLZjRUVHQwbVhNUnFDdnc2ZzZRay9oVWtyNUFUWGp2bW5RYTQwR2d2?=
 =?utf-8?Q?wNR1bUv7w4pxd2giMQ3FLhff/VQSYQixdmJNuMnNdSkKn?=
X-MS-Exchange-AntiSpam-MessageData-1: 4cLXdO94khu4Ww==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aaffaedc-08d0-4123-c2fe-08de78568d88
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2026 12:23:47.2271
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3cdFwNSmy9DZlHHYlntWOu40uC0czgYHD1gT4LNN50H8lAUodLc6kBTyHk5tQtlPG77f1YLv9N9/CgeA+gl0nw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8511

On Wed Feb 25, 2026 at 7:53 AM JST, Joel Fernandes wrote:
> PRAMIN apertures are a crucial mechanism to direct read/write to VRAM.
> Add support for the same.

A few design thoughts that are not immediately actionable, but might
become this cycle if we get a tag with the new `Io` work.

Basically this feature is a prime candidate for an `Io` implementation.
It maps onto the BAR, has a fixed 1MB size, and needs to be accessed
using various sizes. It is also used to fill structured values, which
the I/O projection work will also allow us to do.

The current design doesn't allow the user to explicitly set the start of
the sliding window - this results in a sub-optimal usage of the hardware
and more complex code in this module. At this level, we just want
something that exposes the hardware as it is, i.e. "give me a view of
the 1MB of VRAM starting from this 64K-aligned address".

Then on top of that we can implement another type that handles the
window automatically if we want, but I don't think we will actually need
it. The page table code will most likely want to set the window to the
start of its structure, project it, and access it using compile-time
checked offsets.

If that turns out to be insufficient, we can always compose something
more complex from this basic piece - but the base `Pramin` should stay
simple and truthful to the underlying hardware IMHO.
