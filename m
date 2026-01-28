Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011062.outbound.protection.outlook.com [40.107.208.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A01F3361644;
	Wed, 28 Jan 2026 15:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769614052; cv=fail; b=LhWEMXhOqRMfBD3sTvGng1P6A6i44Q/yiSUuUOesmf32gLih3d/0o2m9ba/1q82BDGQlCUrQEBRBJ1fiHnWUYFxTuvtpAg9cKVXDTpiXHfOKYXz/pRTv/yNGeZJvf0Rbcg6n2+/Cx7nvRltN0uJqU12797Vn1v/1GdKZxzsXFoY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769614052; c=relaxed/simple;
	bh=wcKGDeghsDHMnWCDC7SHIeFQqVn8XSd0+B5JuYAlchs=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=dgvNd4wRSqxmK85rRMnevwLfAmm0hsbnb7wiswsHZ2fhGgCVr/hyYpclW1crjUSRlFHjsNUO8lZL1E+SMGxUlVE/i4as9bB7ScAYFkSW/qlvVsmuvjw6sex76p81wsY/BUT6hy8TAqRDY90dn0DXYYUd1ppYs5zi/wdASDGsAYw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=gHvVM4R9; arc=fail smtp.client-ip=40.107.208.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="gHvVM4R9"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X6qtxypANqp28iyylORWDHOtYqAGLaTH7UTXK57D9wy/cCnz4sRv0ppXODSayR7qynUgXF6REAZAFYf8BePe9vjwvHa9fY3e0id35FMJg0uvZmZ9MSTyPaZsZ7BBbd5/Um9f7MEfz8mwRZ7byCTKxCClm884GLbOFMDp+awgF9yRJxp1rdtwqcfU2Ai0qDt30kqStyWJso7jgHDtt6hNDz5oNfePmU7LXo3DsmTHjA0cnACd0e4CtD6tWUDWuhiNc3crUIRIAezWbIKuwa2ue0ik///4FjkWoOx8oMUBLVJSqnklQckV4KhbDuJMYDYQ1Zi3DsW+v0RyFHYh6I484A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/j9q4q/MWRH/p2rzyakB0MLsjzzm/pmoh6D3o4+MUq8=;
 b=mLSoEJJnHf5IIjLz3HXMLStsqcUiV65PnfUNAn2v1X0szftwRWsKUhib7WPH8Oe5dIqQYSjwHT6aeJ/1YZ/sUwj54wsnOSjR2GoE/A3V7Qix+RejkVbaiiC0PBWzMos0B5qDoTCMWlRyVaezvT/xIkro5pyz/3mfy9tnLsHHUo2C40D5rn/BG3I9XN5KaXQRY7M+sQ16nxkdZlkvzqKfRQwztKwLFlZ1yUhw0wCjAaulJ5tWhNwHXAK4saO0rU19mFzntnm9D7gOMqvBhD2QM336RazA3xJJum1at25rgkRifuZAPHXIixZVlUo5vpwvVbYcCKHoehj2b/YBNeNgLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/j9q4q/MWRH/p2rzyakB0MLsjzzm/pmoh6D3o4+MUq8=;
 b=gHvVM4R991OGrx3YoN5aHr8ahxiz1y8WrE3p3X3l44glQ2vLna938kTG2vvj9VtzWVUpvBeSRg/g1eb7lD87RXK1JPXOLu90OrYfwWHDkDALci5M7X9c33b/wBDcG1OGWSWk307S61ksVqsKhLo3g8OpLHl2Hu3Pf08bxw5dCuReXFT8R6SermTp5QdyPZ6mRdLGRZmIW66P5hA7v5oHaXM9twvhhOaA6BeV2/QTG1lEgn7A+jwtbvCy6XNWGh5t7yhnu2LfimZk59t8rH+gcVwAqESYRGnvVtU87oLS3c1feqkGSFNEdBbB1DO35zrB+JCZE1zNnyfMpR2NeFoglg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB6486.namprd12.prod.outlook.com (2603:10b6:8:c5::21) by
 DS0PR12MB6414.namprd12.prod.outlook.com (2603:10b6:8:cd::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9564.7; Wed, 28 Jan 2026 15:27:11 +0000
Received: from DS0PR12MB6486.namprd12.prod.outlook.com
 ([fe80::88a9:f314:c95f:8b33]) by DS0PR12MB6486.namprd12.prod.outlook.com
 ([fe80::88a9:f314:c95f:8b33%4]) with mapi id 15.20.9542.010; Wed, 28 Jan 2026
 15:27:11 +0000
Message-ID: <c0a3ac65-e2e5-4b62-bc75-49b1599e160f@nvidia.com>
Date: Wed, 28 Jan 2026 10:27:07 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v6 05/26] nova-core: mm: Add support to use PRAMIN
 windows to write to VRAM
To: Danilo Krummrich <dakr@kernel.org>
Cc: Zhi Wang <zhiw@nvidia.com>, linux-kernel@vger.kernel.org,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Jonathan Corbet <corbet@lwn.net>, Alex Deucher <alexander.deucher@amd.com>,
 Christian Koenig <christian.koenig@amd.com>,
 Jani Nikula <jani.nikula@linux.intel.com>,
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>, Tvrtko Ursulin
 <tursulin@ursulin.net>, Huang Rui <ray.huang@amd.com>,
 Matthew Auld <matthew.auld@intel.com>,
 Matthew Brost <matthew.brost@intel.com>,
 Lucas De Marchi <lucas.demarchi@intel.com>,
 Thomas Hellstrom <thomas.hellstrom@linux.intel.com>,
 Helge Deller <deller@gmx.de>, Alice Ryhl <aliceryhl@google.com>,
 Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>,
 Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
 Bjorn Roy Baron <bjorn3_gh@protonmail.com>, Benno Lossin
 <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>,
 Trevor Gross <tmgross@umich.edu>, John Hubbard <jhubbard@nvidia.com>,
 Alistair Popple <apopple@nvidia.com>, Timur Tabi <ttabi@nvidia.com>,
 Edwin Peer <epeer@nvidia.com>, Alexandre Courbot <acourbot@nvidia.com>,
 Andrea Righi <arighi@nvidia.com>, Andy Ritger <aritger@nvidia.com>,
 Alexey Ivanov <alexeyi@nvidia.com>, Balbir Singh <balbirs@nvidia.com>,
 Philipp Stanner <phasta@kernel.org>, Elle Rhumsaa
 <elle@weathered-steel.dev>, Daniel Almeida <daniel.almeida@collabora.com>,
 nouveau@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 rust-for-linux@vger.kernel.org, linux-doc@vger.kernel.org,
 amd-gfx@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
 intel-xe@lists.freedesktop.org, linux-fbdev@vger.kernel.org
References: <20260120204303.3229303-1-joelagnelf@nvidia.com>
 <20260120204303.3229303-6-joelagnelf@nvidia.com>
 <20260121100745.2b5a58e5.zhiw@nvidia.com>
 <e186973c-ce31-405a-8bfa-dc647737a666@nvidia.com>
 <DS0PR12MB6486717785F6DD14EE1F1C46A397A@DS0PR12MB6486.namprd12.prod.outlook.com>
 <DG07HZN0PL87.X5MKDCVVYIRE@kernel.org>
Content-Language: en-US
From: Joel Fernandes <joelagnelf@nvidia.com>
In-Reply-To: <DG07HZN0PL87.X5MKDCVVYIRE@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BLAPR03CA0068.namprd03.prod.outlook.com
 (2603:10b6:208:329::13) To DS0PR12MB6486.namprd12.prod.outlook.com
 (2603:10b6:8:c5::21)
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6486:EE_|DS0PR12MB6414:EE_
X-MS-Office365-Filtering-Correlation-Id: f7fa8dea-6541-448a-cc06-08de5e81b501
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WE9tSExuK3hUdGc2YnpsRHp0Ujl0b1ROMUtIMzNnQTc1dmZBUWdCWUV2Q3FE?=
 =?utf-8?B?ZWdCZWdtWjkzZzRRV2JRbUVZY3kyQ3hmQnBaS0tMTFFFZjh1VGR6aUtveFFx?=
 =?utf-8?B?NXQ1ZFhkak91MnRJaUxSaUpsOFA4U29GcWRQcVdRVUo5SHEyWFJlVS9MSHIy?=
 =?utf-8?B?T1FXY1RNUDhqL1oxZ3ZweWtiM2pjU3lRNTlaU1c0c3V6N0hBZHg0d085RkxY?=
 =?utf-8?B?ZXRBWFlMVmptU1o2cnpEOXgxVGJLdnNkb3MrMXc3ME1OQ2F1QW9Ib3ZWKzNY?=
 =?utf-8?B?QVhleUJaMzd6eWxGbXNPWFNDZGtVajlhK2d5RDN5cGgvRFR3K3lyZ0Nwa3hZ?=
 =?utf-8?B?U3A3WHNqVDBXVnYrUzNKNGlpTEJ3U1FveXYzWFJ0RnFwaDl6ZTBremQ5anRX?=
 =?utf-8?B?am5xY1N5R0xiK0hwUFdBK1c4R2xDRmJGdFRiUVRuend6c3ZTUWF1OVlMVlFi?=
 =?utf-8?B?RjBUKzM0SlhHNXhicWszS25zNjBFamx5ekdrZGNuaXkyd2hCb3Q0MkY0VHpj?=
 =?utf-8?B?dHFIdk1xVmU1NW4yUlozOWlldkJzSWpZaXk3THloRG5VWHFHUE83cEhnYmZ3?=
 =?utf-8?B?anZVbXFkV2dsTmlvcjRVZ3JNT04yQUhrZEpCUTdZcnJBaDZyNk1uTGxjTmlL?=
 =?utf-8?B?REFNdzNxM0x0ZlgweEZBdE1hSnRrdUNoS3NyQS9xb3NyQTVRU09PUEdOUVEz?=
 =?utf-8?B?eEhnYmd0VU5iSDgwQUZtekl5UE9RUXMxWVNHUjI1L2FHU09ZUFBXVFdHcUZS?=
 =?utf-8?B?bjJZa3lmNEZGd3JQREEzcGx0aGdMbS9GNkx1MDRHY1draTF1bjhsbm9MQzd5?=
 =?utf-8?B?NzdrMlVEbHIyUG4vMFBGYjV4ZlcrZWRpTXp0dkg3VUZWMnEvUERpd2UzY2JN?=
 =?utf-8?B?S0hiRHExVGdIS0p4S0tITTh3L3ZUN2JsM1U0bmM3bEFJaFNMcEJLNkovaFBw?=
 =?utf-8?B?NE9VZDdUa3ZJaXFDUGRwZDBQRHpjR1U3V3YzVjlBNVIzemV3aE1TYmM0Ty9i?=
 =?utf-8?B?QWlLelhxUGt5c3M2Qk03OWZqWjl4UGFYdEI0SENEK1dZWThTZ01TVjZRKzNa?=
 =?utf-8?B?UlhJeDBkVzRlaXJ1ZmE1dExSc0t1MHV1a3NTUlV0T3VJNjZ6OHNqaWM5MFVY?=
 =?utf-8?B?ZnRIS2N1WlNISytQMWdvVU9CN3BoNkVhSEVqK2JCM0p4MkZFZHBnYzVFUmps?=
 =?utf-8?B?TnlrcHlBQVNEUnpRUHppRmpjNE5YVzdFVVUweTNudko3SHpHbGJYOGQzQlhE?=
 =?utf-8?B?NUwrbjlwZDJYUUg2MzNsNSt5YVpZN2tCNkxnbXd4aDJlK3FobWJyVWt1S1lT?=
 =?utf-8?B?TFhyYjlUTk1peWRKOEtMZHFhUXNsNXYyK1JaVmVDUXFrYkE2VVdndVFUK0Rq?=
 =?utf-8?B?eWJidWlKckhPK1JTVFJWOHFIV0ZoK0I4ZW8zclVpMVFxWC82Z0dHR3hHYTJZ?=
 =?utf-8?B?SEQ1RnRYWEV2Z0wzcGhhYTNwZzVHZEFCMzFLVTdlUlFhNXk4aW9PY056Wklt?=
 =?utf-8?B?Y2dGOWd3L0J6cHZoM0VjaERZWHVjbUFzektLMHRPbUo4bmw4TDYyeERzTkpt?=
 =?utf-8?B?TUl1c3JVdmoybTZ4UkFpeTR3RjRzY295QXdmZWVIR1B4cFJGellLSTI4MDk4?=
 =?utf-8?B?dGZZOHJIczkxc0NPeGV3LzVWMGNybU5OaEVvRmhyZ1oycFNUSEZCVURacllI?=
 =?utf-8?B?VWpjamFlVmF0Yyswa0JaMVVtNEpxOUhMMGlLNVhLMThwU0hKUmNaRXM2bVFX?=
 =?utf-8?B?YjdHdndIWHVtOWc3d0hTSWdKcmNUd3d6M2FVNCsxUVVqYzBwZTczcGdWSHo5?=
 =?utf-8?B?cTJ6c2ZpUFRxbUVrSW01b2ZrQnJKakd5eUd5eTdKTmhPRmZTRjNQc2h3K2V1?=
 =?utf-8?B?RjlMUGFXMnVDQ3RmdGxkbk5RcVo3eFdOYm4rdlZwS2RNaUtFU3BGSkUyT0M1?=
 =?utf-8?B?QWt5dzlrdThYMG9YckhoN1VVUzJXV1VmODBoQUIybVUxSUp2UjJFcUhUeE1U?=
 =?utf-8?B?WlF4Qmx3UVhiaDNpTEIxaHUzTi84czB3UEVycnlXSFM1S3hvRXRVQXJ4ZlhO?=
 =?utf-8?B?TzcvR0NlYlFPVTVNZU9WR1Foekxvc0JkeDE5c2lpc3l6WlUvSnFPVzZiOUdD?=
 =?utf-8?Q?VSJg=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6486.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dnB5TlVqWTVqN3M3RGJjc0tzNC9ONk9GNEhpL1VRSHhPZVE0eEw0a0NVYlA5?=
 =?utf-8?B?OFZpbW5sdElienFjUG1MRENzR0RKY1VZR2lPUEJTSHJiRUZIejV5SzZQc0xC?=
 =?utf-8?B?SEdiWmVWRTZPQjZIV2l6aDN4b2tOeHRScVNlN0lzTUxmaUcvN2ZQaFBmSnZH?=
 =?utf-8?B?TWRYQm1ES25uTCtUVEhiMjgyL1NTT0VQTEcyZGlEV3ZJRGtXV3RMRGdrVmkw?=
 =?utf-8?B?cW41N2s1Y25rc0sxcUdvT2dnV0wvblBleEFvektpdS9iNVFnN092UVovaEpz?=
 =?utf-8?B?elBtMnJCZS9WT2JuamNGU0VwNEhZRUJrbDVycndXZjViMmlXRVBDMXVuMk5Z?=
 =?utf-8?B?V3RuUFR5SHg4NU5Eenh1QStyV1NLOTBGazZYMHdIMUxYT2dTVlM3ZzRyMWh2?=
 =?utf-8?B?eHJxSlZ6QndIRmRIOWlINWZmbjNxbVBEaDRWaitkcExOajJBaWdDTTRoYlZI?=
 =?utf-8?B?NjJ2Y0xXVXZxckpEVnVqZzhNVEQ0c3VjOVM2UTE5UkMvanZnNFVJcVRBL2NJ?=
 =?utf-8?B?R2VET0lFQmNYaVFvRzdqK2MxbWNGMy9UU2xQOTE5VmovZHVDdEg2K1pOd01h?=
 =?utf-8?B?bCtUc3FscUpWbGlVV2xrOXllc1pna3pGMDAvUjZiOGtYZmFZcmJoTDFVV1Zj?=
 =?utf-8?B?QU9QaFJZd1dEejBTbTZxU1JlM1JJUHFRQ09yYnFiVXFpTVNwTDRRNW8rWGZR?=
 =?utf-8?B?NXkyeUdOQVh4ZTQvM3FKSXJXQzMvaCs0c0ZSNkMxSEJsaW5WTUNmZGZFa1NP?=
 =?utf-8?B?WHNwNDE0R0ZPeE9EZmxrT1lQMHBHbStnbFpQZGlSRXhiQ0xGTUUxR3BXT2Zx?=
 =?utf-8?B?cGt5L3lrV0o1VGdvQXBpbUEzN3NFV3FCVTVHcVphUi95Q1VvcFI3VEJKZG5a?=
 =?utf-8?B?NUdOdXYwNmJtWHNmaVh5bnMvbWhCS0NsbE15R29jUkovOHBPV0JKeGptN0hV?=
 =?utf-8?B?dUtUejVuTk1FcVZzczBUNHZyNzA1MXY5b3lxVkpmUVFKYjc4bXo1TEFRVkE3?=
 =?utf-8?B?b1l1TklXVFJjc1pLbFg4WXJ5YVBHelI1K2g2RjFlQ0RUWTJGYkFWelhyMjB0?=
 =?utf-8?B?QUI1TzVBOW5FaFpBeFlVK0xOa2FFOWhPaUsxT3pkSmtPc2lBTTlZTUNuUXAv?=
 =?utf-8?B?Y1NGRmlMeTJrZlAwVzF2MGxLSmg5anhPYUpKU09xWTlqUDVKLzB5UFdTZm1h?=
 =?utf-8?B?bGVpZTR1UHJGMGQ1NFVWbDMxMHc5NXpUa0xIcGxXMlpreW82MERhVUNtRmZT?=
 =?utf-8?B?S0JuUVJJNlFrUk5PUThhOWNmYStrRkpjMXhRajc5cmNUcnhCK0srbis2K0oy?=
 =?utf-8?B?Q0ozdnNzRnJVdS9BUS9NRVdBZlAwaTZRZEFTMTlQMEl6T1krazR6NmdaMWp5?=
 =?utf-8?B?ZWRGRFNGUzBnbXFQTDU4R0orV2hhQVFBOVRjbVVzbmdFWHlZdjNEbkxFTnBM?=
 =?utf-8?B?Y0U4a0lDcVQ3QW5ndWxScVp4NHFBSzVWWDhsc0FJbXpEYnZmb3hIdEQ2TlFm?=
 =?utf-8?B?bk9tU3JZVXAwM3NZY1JlTUFvbHhnbVU3a2FVeWdxaUJPeFNpV01iN2FZWlEx?=
 =?utf-8?B?N29UREhySHZLVm5wc1lqcm5vU24rWUp3UkY3dzdXNnlib1VKZGV6emlZR2J6?=
 =?utf-8?B?bmt0azQzK1ViZ1YwZ1hBbE9mZ0QvS3hVcWdBR3lsQjBxbkNvYnNIWjZIVloz?=
 =?utf-8?B?SVZtdUlzRWY2U0hQOHVhOXJ6TUZWLzY4d1NJN09RSDhtT2VSWjR6QTM2TytT?=
 =?utf-8?B?YVdWSkphQVZzNDNsemMvc0lyVnhnL2hwQmR6aXZnY08xTkM4dlFKZ21BanZu?=
 =?utf-8?B?T1VCWldIdnFuMlNvN291K1BJYmZIb0dWQXo3VndNanRJTnJwemdBcWRqcm9C?=
 =?utf-8?B?ZzVPSVRocUg3am5YVWRQSzlpNXVXWjFTYVlYWVBWTzFYZ1d1Q0NVT1Z2Mm10?=
 =?utf-8?B?MU11b0UzS0R4YUpJN2MzaS9kTnJwWW5kWUZLMXJKSWM0SDhtOXZnVG02OCtW?=
 =?utf-8?B?UDZkVHdsdkFUWnBGaXd3WCt6VGlKTUhrVHE1ck9mNktOc01RY0hKd3dOU0I3?=
 =?utf-8?B?bGd1b0ZtU294emhITTdTMTFoV3NYaXJwcjdvWGY3M0V6SExVbWVSS0JkQ0Nk?=
 =?utf-8?B?czNDakpwMzVVcmJQWDBCV2owQThXdVRLc25UeGgyb3lqOFhMMjJPcVFqMVJH?=
 =?utf-8?B?VEFlN3BZOEMyQkhFQk53MXRLdWtiaHl0NFplS1MrbmhPdm03N0p3RmdHRGhq?=
 =?utf-8?B?TTNtYnVaOStYME5HbEdkNzR1dTEzZXRHMFZuTHhmSE9qNHcvNHdTNFJ4ZkMv?=
 =?utf-8?B?RXZyY05MSm05TFgyNDEzYUhXNXc2eGdxeWNOZ0xMOFU5Vm1QaE5Vdz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f7fa8dea-6541-448a-cc06-08de5e81b501
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6486.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jan 2026 15:27:11.6110
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: I85G8rcX9a1+ZpnSE+gRpBLEStXJkXXXjEBMUGKe1kTGUo9F7NpGibEj/Xk+BDw5dBBpw7m65D+EMCc89BN2wg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6414



On 1/28/2026 7:04 AM, Danilo Krummrich wrote:
> On Fri Jan 23, 2026 at 12:16 AM CET, Joel Fernandes wrote:
>> My plan is to make TLB and PRAMIN use immutable references in their function
>> calls and then implement internal locking. I've already done this for the GPU
>> buddy functions, so it should be doable, and we'll keep it consistent. As a
>> result, we will have finer-grain locking on the memory management objects
>> instead of requiring to globally lock a common GpuMm object. I'll plan on
>> doing this for v7.
>>
>> Also, the PTE allocation race you mentioned is already handled by PRAMIN
>> serialization. Since threads must hold the PRAMIN lock to write page table
>> entries, concurrent writers are not possible:
>>
>>    Thread A: acquire PRAMIN lock
>>    Thread A: read PDE (via PRAMIN) -> NULL
>>    Thread A: alloc PT page, write PDE
>>    Thread A: release PRAMIN lock
>>
>>    Thread B: acquire PRAMIN lock
>>    Thread B: read PDE (via PRAMIN) -> sees A's pointer
>>    Thread B: uses existing PT page, no allocation needed
> 
> This won't work unfortunately.
> 
> We have to separate allocations and modifications of the page tabe. Or in other
> words, we must not allocate new PDEs or PTEs while holding the lock protecting
> the page table from modifications.

I will go over these concerns, just to clarify - do you mean forbidding 
*any* lock or do you mean only forbidding non-atomic locks? I believe we 
can avoid non-atomic locks completely - actually I just wrote a patch 
before I read this email to do just. If we are to forbid any locking at 
all, that might require some careful redesign to handle the above race 
afaics.

> 
> Once we have VM_BIND in nova-drm, we will have the situation that userspace
> passes jobs to modify the GPUs virtual address space and hence the page tables.

Thanks for listing all the concerns below, this is very valuable. I will 
go over all these and all cases before posting the v7 now that I have this.

--
Joel Fernandes


> Such a jobs has mainly three stages.
> 
>    (1) The submit stage.
> 
>        This is where the job is initialized, dependencies are set up and the
>        driver has to pre-allocate all kinds of structures that are required
>        throughout the subsequent stages of the job.
> 
>    (2) The run stage.
> 
>        This is the stage where the job is staged for execution and its DMA fence
>        has been made public (i.e. it is accessible by userspace).
> 
>        This is the stage where we are in the DMA fence signalling critical
>        section, hence we can't do any non-atomic allocations, since otherwise we
>        could deadlock in MMU notifier callbacks for instance.
> 
>        This is the stage where the page table is actually modified. Hence, we
>        can't acquire any locks that might be held elsewhere while doing
>        non-atomic allocations. Also note that this is transitive, e.g. if you
>        take lock A and somewhere else a lock B is taked while A is already held
>        and we do non-atomic allocations while holding B, then A can't be held in
>        the DMA fence signalling critical path either.
> 
>        It is also worth noting that this is the stage where we know the exact
>        operations we have to execute based on the VM_BIND request from userspace.
> 
>        For instance, in the submit stage we may only know that userspace wants
>        that we map a BO with a certain offset in the GPUs virtual address space
>        at [0x0, 0x1000000]. What we don't know is what exact operations this does
>        require, i.e. "What do we have to unmap first?", "Are there any
>        overlapping mappings that we have to truncate?", etc.
> 
>        So, we have to consider this when we pre-allocate in the submit stage.
> 
>    (3) The cleanup stage.
> 
>        This is where the job has been signaled and hence left the DMA fence
>        signalling critical section.
> 
>        In this stage the job is cleaned up, which includes freeing data that is
>        not required anymore, such as PTEs and PDEs.

