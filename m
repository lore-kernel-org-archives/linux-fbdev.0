Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012062.outbound.protection.outlook.com [40.107.200.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B043234FF4F;
	Wed, 21 Jan 2026 17:52:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769017941; cv=fail; b=drV8mnlg/Dyqy9pljjy6JeEHxn7PflFbJ+Fpkz1Z9FAhphjn/ENDCFi3dKMVEJd0YgDT/BLyO/6T/styY3fue0iTL1xayl66y4rB8/QN1BnbttC6MMk4l1p6W/KiXZRv5FTrJNdFprR0enmYwrLui2Zry3YU+kTA/AgX12j31vM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769017941; c=relaxed/simple;
	bh=6jgu+nuDxCUeiP8WqstNvBsItAb+wqU6V9MeY1j8qKk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=NCmrOrGO1Rd8Gd5Sv7T9BIMW5kdyyCXQmVcs1KZsabB+yIugaaxtSVAMihJdkYBEgE8+odW2s6+i+5SFEeHPbBiwzYWjdjynryd96asFEgWrURQ2Y+/kw9S3BJh5Fdp/lxlFWRjjm7OOKgykYCmmGdF7Yv1GMzoYbAtqqQ+HDI0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=eda6/irk; arc=fail smtp.client-ip=40.107.200.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="eda6/irk"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mkscHGXx0YM3Pp5+d6DA0qAFIBbMT3T1VKy/ehmotz+umy0uXTgqJcK53maiX6YNwkHVTlgIl/WtBtz1o71FjIS3MVDZJ3TmsvZNZefEDarO21Q+gEkTwLW15aSg56rW6ONODSSwV1ZrhBkhzsTmX9AuYo7GgO5Hcpq0dnmBNAFbsDfangHA++8PzUUohzpldk4a6+4+k48qBcZv6gVgcGhI2KBINebbrc8oGGmFkX8afBRLkBFoYg8U966haSzKM6lYCWRNhU+UcE2oyCMUOzwwA9Tkvh7olCLSHbQwV4Z9v4lF/fOzhbOs3fIKhq7tFAXVkY6kiIM0y/0MBwRRHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wvpWrSJmN4UTmnXvAGNDKsZljTvLLoTMi73/0ZasXN8=;
 b=g3YqqB7HB6WjbET+d9vqohulyI2H2g0ughuva7hGkXhPKqTaqqmm3533HPGDw6zgdHrZBXIH7gQpr8kLIGjsJ8vSyv6lXUQZj7yeCnIn/EvIp2YRfGoVaM+zufrItJefjjnd3AyrmoboIjzPNn+T9FweT2lEPtHGwKCT6zHEwoEIDQ32AR6nRkYrAIKBvdi4RXPbVizhk5xWD0/qr4dUQSaKeZkWkPyOpuU2HfE+YsXVCa62I0bI4r+wRNsWnvQo65O5irLFm7pPe7DhxQTrhHA5hZChx1S4SqOsFQ+qwVCieZU5bSy3O+K71/bh/dQ7lY0iVQGwXiqoJqmIoysdJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wvpWrSJmN4UTmnXvAGNDKsZljTvLLoTMi73/0ZasXN8=;
 b=eda6/irkAkQYQdjY8355XP13xQJsFmrzFGwRyrwchI+WtxUXizeVhkIWc3IaQvQCA6EhhXFiX19r4kUIHLPh0ppurGRn6GPPG5lezp+GPXtIxfT9OOv8YRMzIr1qs/es5I2neUd2xO0g5HsaFEQ4WJaoP07/aBuzslbdIizSpTov23iYUWkkBjEnqZLDS8VY8pXUXdjQ/ZEPqKbAtjb08m9+mwQe7JP+9DQOtS2ikkA7F2nCt7dXidfWbA2wcclwFbS1jeKXRQxchpfkT5WO8tFrJrjx8oRan7V+OMmd31LSTxJIcMu7d8XvRoJou/XNPbVH3K8C2MJmKGQbkDrY1w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB6486.namprd12.prod.outlook.com (2603:10b6:8:c5::21) by
 PH7PR12MB7940.namprd12.prod.outlook.com (2603:10b6:510:275::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.10; Wed, 21 Jan
 2026 17:52:14 +0000
Received: from DS0PR12MB6486.namprd12.prod.outlook.com
 ([fe80::88a9:f314:c95f:8b33]) by DS0PR12MB6486.namprd12.prod.outlook.com
 ([fe80::88a9:f314:c95f:8b33%4]) with mapi id 15.20.9542.008; Wed, 21 Jan 2026
 17:52:14 +0000
Message-ID: <e186973c-ce31-405a-8bfa-dc647737a666@nvidia.com>
Date: Wed, 21 Jan 2026 12:52:10 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v6 05/26] nova-core: mm: Add support to use PRAMIN
 windows to write to VRAM
To: Zhi Wang <zhiw@nvidia.com>
Cc: linux-kernel@vger.kernel.org,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Jonathan Corbet <corbet@lwn.net>, Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Jani Nikula <jani.nikula@linux.intel.com>,
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>, Tvrtko Ursulin
 <tursulin@ursulin.net>, Huang Rui <ray.huang@amd.com>,
 Matthew Auld <matthew.auld@intel.com>,
 Matthew Brost <matthew.brost@intel.com>,
 Lucas De Marchi <lucas.demarchi@intel.com>,
 =?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 Helge Deller <deller@gmx.de>, Danilo Krummrich <dakr@kernel.org>,
 Alice Ryhl <aliceryhl@google.com>, Miguel Ojeda <ojeda@kernel.org>,
 Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>,
 Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>,
 Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>,
 John Hubbard <jhubbard@nvidia.com>, Alistair Popple <apopple@nvidia.com>,
 Timur Tabi <ttabi@nvidia.com>, Edwin Peer <epeer@nvidia.com>,
 Alexandre Courbot <acourbot@nvidia.com>, Andrea Righi <arighi@nvidia.com>,
 Andy Ritger <aritger@nvidia.com>, Alexey Ivanov <alexeyi@nvidia.com>,
 Balbir Singh <balbirs@nvidia.com>, Philipp Stanner <phasta@kernel.org>,
 Elle Rhumsaa <elle@weathered-steel.dev>,
 Daniel Almeida <daniel.almeida@collabora.com>, joel@joelfernandes.org,
 nouveau@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 rust-for-linux@vger.kernel.org, linux-doc@vger.kernel.org,
 amd-gfx@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
 intel-xe@lists.freedesktop.org, linux-fbdev@vger.kernel.org
References: <20260120204303.3229303-1-joelagnelf@nvidia.com>
 <20260120204303.3229303-6-joelagnelf@nvidia.com>
 <20260121100745.2b5a58e5.zhiw@nvidia.com>
Content-Language: en-US
From: Joel Fernandes <joelagnelf@nvidia.com>
In-Reply-To: <20260121100745.2b5a58e5.zhiw@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BLAPR03CA0158.namprd03.prod.outlook.com
 (2603:10b6:208:32f::24) To DS0PR12MB6486.namprd12.prod.outlook.com
 (2603:10b6:8:c5::21)
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6486:EE_|PH7PR12MB7940:EE_
X-MS-Office365-Filtering-Correlation-Id: ab6f7b81-2764-4aba-869e-08de5915cf53
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WEpZRjhsSzZmL20zSTlQSnRvL2IrcTFpZ1pKL1pyN0F5T2UxaW5pbkpzUFEx?=
 =?utf-8?B?MzlFR0xpS0ZrTjVKalFJd0I1ZjZVSTk3aTJOeGVySVB6ZEFjamNtRFdLa290?=
 =?utf-8?B?OVh2Zy9qVHhlMWVZbDJkQmlwWmVCSWZsYW8vS3N4V1d1eHhQNzlPdUlWNy9p?=
 =?utf-8?B?aEZwazFPRVB0RExvRWdWVHk1eGFpaE9jYnVDWUw3RXhMM1Y2b1BYRE0vRnZP?=
 =?utf-8?B?ZWFZaXJkdm1QRWh5aitQNy9PaStZV0NBRGVWdG8yeEFQOXZrbVdlcHZXL2tj?=
 =?utf-8?B?S3Jnd2xBN1dWN0hQQllremRIRjQ3ZnhPcFZDV0t4enRIdC9ReHdOYmUvRzhF?=
 =?utf-8?B?WUd3NG1obnc3d3VtZDRTMTJqd3RnUlNJR1NIQlV3UmcxbmNVeDFOTnh2RXZH?=
 =?utf-8?B?RVFocW5WN2owSEZ3dWkwYmduSFVGekxtekJodktPUnZZQ2VydjBHa2V4YlZ6?=
 =?utf-8?B?d1R2clZpQUFjRDduR0MydnVvb0J3ai8reGFZV05zWmoyY3EwVjJrQUw5bnRG?=
 =?utf-8?B?YzFqcEc5UWpzczExQVNwaTJqOWxReDZ4L1BFcEVlSW51OGdPV0NQZCtFKzBT?=
 =?utf-8?B?K3B3Tm45MUFXNi9tVnFxa0NEbHlWMEhjQ0RFYWkxazkxRFVUdVFSR3Y3cTQ1?=
 =?utf-8?B?cXBzQitQQmRLMlBHdURMVEppOUV2YWpMVzJHamRzNzBvY3F2c0ZjdTA0dW43?=
 =?utf-8?B?U2ppSXo3Y2p5NnpkZ1I2dk9MTmZNR3dZanZUV2ZnVUNLVkxQalJRMXVzbU5I?=
 =?utf-8?B?UUtPUzB2K1dTQU95Sk5HMkIxOThxUCtGVDRvZ09UeDBXeXkwRFBucE9neGwy?=
 =?utf-8?B?Z1lJRktERU1iYytKOXlaTUdwREJVTWNNZHZvSVk3Nk5VaEFUQnBOSThpRWEy?=
 =?utf-8?B?U1lyK1R2NHpLZ0IrMHV6d1MzbVZQb2IvQW1hak1OUUJXVHB1Mk5xS1ZoM2px?=
 =?utf-8?B?algyTTZHREVWU0ZhcUQwMllpZmhTeUdlTEFXSzJTZURYTUszRWRKbUFmek43?=
 =?utf-8?B?YndtMzJ1ZmNZUDh6bjY1Vi9KdkFiN0IybEJSOGtKcWhPd0QyTVI1ZndSRXdw?=
 =?utf-8?B?ZTRKdS93ZXUzQ21WMnFSb3Zrb2JiTmtnM0RFNzlhZm9nVExZVGVqTFRoSmlJ?=
 =?utf-8?B?ck5KNFlhUFUxVFd4Sm0wN01lNU96VlV0MVVaTzBEd3d4L21vcWU2Q3VEOWRT?=
 =?utf-8?B?cWJ1Zm5wNmhhQ0FWRllSQ2lQVEhBTmFmY3Y4RjVJNFJ5UWxHaU96SGJZbkZG?=
 =?utf-8?B?Si95WjVrcFFITUthYlNDNVlkKzQwb0RYUGt0QmI3ak5UTzhxYldRM1pHTVNm?=
 =?utf-8?B?dkIrckRFRHcwbHcwR09DZk9QM3RhOUtyTzhDUCtEM0J5L095NkpMZWVSK0VZ?=
 =?utf-8?B?ZW50Vkd0N1crSHAxRUZwakY4dU1vM283b3JhT0J6UTZoVVNpRjUwTG5aT3Jh?=
 =?utf-8?B?YmFXZ1UwUjYxTHZka2toOEJDZVIwYUxOMnNKZDY3YW1zQWk5Nmx3eFcydGM2?=
 =?utf-8?B?My8vZmJaNXVWL0VVTTJGMUZZbDhJTGhUUHZRUzVvZ1BIV2daWUVyV3MxYkda?=
 =?utf-8?B?amRLWGZSSjBtZ0hJSkVHWWgxRWVCYzJCZFlqVHRmdFRET3g5aEo0WGFFOUNk?=
 =?utf-8?B?SDZtS0d1V2ZPdE1zNzUvUi85aThMYXZqM2VBTm81UFNwNTJHZEdRVUxMZlJk?=
 =?utf-8?B?dUZvbGZrTjFPM1ZmZUF1Z0x0WG51b1gvL2hiOTM3VnZzc0liT1l6c2Ntelh5?=
 =?utf-8?B?QUlnczI3Q01KTzZvUkdlNDJmL2JteUlKU3BvTGhrc21pN2Q5NStKQmh6ZTJk?=
 =?utf-8?B?YitLVDFsaE5FU0VFQXBiYm9yaUFRLzNvcndITUpCQzZqM1RUOXdHYjM0NVN2?=
 =?utf-8?B?LzRPQUdhK3Fua1N4ZWpxZkk1eHBCczJxVktqTzRkRDRyaVROOW5YM245REdi?=
 =?utf-8?B?SE12M1hoQ0JNenl0VmxpY25idms5dVJDMkdRaGkwVGJlVldpbUhuaHR2Ti9N?=
 =?utf-8?B?Sm9JT3ZOcmduNmhxVmhrRW9rRnVlNUp0R0hBSG81MnlDYUtBMXlSWVo3eEtQ?=
 =?utf-8?B?T3FQeW5kUWtRQ0VUV0tWRk4xazAwckJaRWptODBseWpSelNwc3h5eGh3RUpT?=
 =?utf-8?Q?b9Qk=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6486.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?M0xpcDFSK3dwaTFPdDh0YUdpSm9XYXB5Z3hUczd0cHdudGpuNDUxbXp6QW9B?=
 =?utf-8?B?UFlJZm1mRVd2bHp0bHFkanZxZ2xmL1ZHd1ZtZUU4Y2FaTzA1OFhlOUo5MktB?=
 =?utf-8?B?TGp2YzRqZzZEdHU4TWEzTTcrM2V1SDMxWEFhY1crU08yRDVxaHdPOVo5MEdp?=
 =?utf-8?B?ck9HdFlTandpQWZkK0lLcnVkWFBSY2lwNlRuTUJDdVJvczhUZUNydzFLRVA4?=
 =?utf-8?B?YkJKSXp4dU56d2ZicFgwanM5RjlDUnhpQUd1RitEdE4vcUJzMnZNQy81d2lL?=
 =?utf-8?B?T05FR3hxY1kvZUlxVW9IVWZvR2M2ZEdVOFNZTVhJOW0rV3dLUjFQRW1FdlB5?=
 =?utf-8?B?cFhITzdNWmJZU1pIdzN0cHpQVjFsU05tOUszVW9HNjlzOFdLYVlLUjFUWDNz?=
 =?utf-8?B?a1l0L3Z4akpaSlVWSGR1TUsxRHBaT2hXRldUVlh0M0NRRGdEZjhuYStBdnMr?=
 =?utf-8?B?Skh2cmhPblBmRE4rZGJ5blpwSEF0SC96cHZ4QVllUnM5QmhmTVR0c2tqSHIv?=
 =?utf-8?B?c3kwT1RPUWF3NVd0UGVVUmNTYWRvekVHcFgyeHJQVkhDY3Q0Mk00MHNRSXJL?=
 =?utf-8?B?V1JhTm1oM0RMZlJRNm5BTjc1MjJvNTFSWi9vT05CTUZXVW5uOGtoNXVReWxK?=
 =?utf-8?B?dDdtcjdBZE9ZcjN1NHdNeHhhUk00Y2h4WDRWZXNhdFBOVndIQlo1LzYrMCtI?=
 =?utf-8?B?V2JSMkM5NFJ1Rm5XQ2M4b0NSYXprU1IxQ1BubEwzR0NtRkwveWwraUdSS1F0?=
 =?utf-8?B?S0Z4RDNwazdKOFZ0dU5lTnkxRTI4UktxMGcxdEd0V1d1RTdXeURyRXltdndo?=
 =?utf-8?B?M0pWWnVNVDJjWDYwamhJRHJTMjkvQlFxV0tQSGdXUndLTThwVkppWTZHT0NV?=
 =?utf-8?B?OUN1S0lJdUdZSk1DS0c0TVVyeWM3WFM5eHVhcEk2VEdiOUptZThEVk1yT1Zy?=
 =?utf-8?B?S0ZnRm9uRTY2Q2QwU1g1T1lxaTlmeUh4UzB2aVpYQUpjR3BYVHB5K2t4Y0dq?=
 =?utf-8?B?RE42RUJBYVkyRlpRQTBBSmFFNmdGZEhtOWJLR01TMEdPY1Y3NENGZlZHUjFK?=
 =?utf-8?B?b0JnaFRUelY2U3doeVRhYUNwRE85OUlSQlZpS0MzdDgvU0FlVVhsSTJ0Qkc0?=
 =?utf-8?B?S3JtUHRGRnlYdlJhYnlLb1ovKzVoNW5HTXZtREErY3lsSEh0ekFQS3FNczR6?=
 =?utf-8?B?VUdnb0RFTk5PUUxYcVNtajFQWmJLcnJqTHYvMkEzZjNOblkwUmNzb0VOMzFX?=
 =?utf-8?B?VjRCWXhtQzVGOUZtUWl2Rk42ZGJPR3JPbnE1d0JaeS8zaVg3OVo1clc2SUZm?=
 =?utf-8?B?VURXUnBKTk9LVHIveVROVDRPbHRoWHcxQ09hZXhSSU5ZU1hxRmdyUkc3Y01B?=
 =?utf-8?B?c2JYUCt0aUJFL240b1hCcWw0TkF3M1JMN1cyS2tiMVQwZWZZQ3h6RVQ2V2RL?=
 =?utf-8?B?Q1FHU2tXcy94SkJLYTRKWHorSGxvYk1lb09yT1NIVWo2cVJ3aHhVYTR2R3Zr?=
 =?utf-8?B?cW9qZDhiRHBZY3RadGVXNG44Zlo5NGgxZkJJSXpERjdxQXRpSEVHb1FBZi9T?=
 =?utf-8?B?SGJ4R2VIWUZwMXhNMFVSTzdXNE1uNm9xM2hBeDRnYTBMaFl3bVBabURkM1dH?=
 =?utf-8?B?RXlZTURqMjQ2SWx6RC9GUkF0N0RkdlBCRHo0VlJwd3VEalRuU2xKblV4OEhx?=
 =?utf-8?B?Q3BKaXBwamZudXNXa04vcnlYN204T1hQVkJhb2dnZHN4cjdNR2ZyOWl2MzR3?=
 =?utf-8?B?U1RNaTg3UlU2YWJER2IrYVhEc3A5MEQrUTc3UjB2bnRhaVk0QVpmYkFxSWRY?=
 =?utf-8?B?bWxsY0tnVVUvdnZyK2U3cEZNQnNleG5mSllLRFNCY0pKZkN0Y1ZJVWVPcUZM?=
 =?utf-8?B?eXZjNnM3b2dpRmFWdXltUkVZeUprZlRGV2tYU1gyNVZXU3B3N1BRdVkxNUtG?=
 =?utf-8?B?MW9ETE1FblgvV0hldEZBRk5iR0hEMUZmcW53K0R5Nzc3ZS8vVG41ckZ6b0JN?=
 =?utf-8?B?dXVIb3JHTllPV3pUYldDcjVwSk1BZSswclhwSGV5YzNYUDJLUkgyTHpNaVlK?=
 =?utf-8?B?a1F4ZWxVMHJHTVo0OXpPRnZIZ0p3Y2FiTlhwZHM1RlZhbmZFcnBSdjZyRlBv?=
 =?utf-8?B?NURybDBDYUNGSk13VUx1YStjQnlFeVBQUlZnWHg2QmozZkNESk8zaGhyd2JQ?=
 =?utf-8?B?NGhrN0paZEM0MFd5dzI1Tm9MUm92NlNEN0xRc2U0THIyaTdRVndrTE1IaUs5?=
 =?utf-8?B?TzNvVk9BNHkvRVBLc1FXdTFpN0FjeW9ORGhUTmRsVDRhcDFzTHBJR0JjYTdt?=
 =?utf-8?B?SDdVVjlTQlU2dy9wbHU5MUlkRTVNL3duYjFOUm1kRnRJaDVyanhyQT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ab6f7b81-2764-4aba-869e-08de5915cf53
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6486.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2026 17:52:14.3157
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Sv95ZC6uLT1VKVaGoJgOh8tnnicJ5GGVTdz/2Km5+64RwsSKLwySxAtd83Yk9/7jdvH/ePI+CDfH29r/GPYKQg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7940

Hello, Zhi,

On 1/21/2026 3:07 AM, Zhi Wang wrote:
> On Tue, 20 Jan 2026 15:42:42 -0500
> Joel Fernandes <joelagnelf@nvidia.com> wrote:
> 
>> PRAMIN apertures are a crucial mechanism to direct read/write to VRAM.
>> Add support for the same.
>>
> 
> I went through the code, this seems not designed for multiple users. As
> this is used for writting PTEs for page tables, can you shed some light
> about the plan of how we should handle the concurrency of writting multiple
> page table PTEs, e.g. when two GPU memory mapping in two different GPU
> page tables are procceding concurrently, this could happen when people
> creating vGPUs concurrently. 
Good question. Currently, BarUser::map() requires a mutable reference to both
the BarUser and the GpuMm.

    pub(crate) fn map<'a>(
        &'a mut self,
        mm: &'a mut GpuMm,

GpuMm is owned by the struct Gpu, so from a Rust standpoint, it is already
handled since it is not possible to manipulate the Page table hierarchy (Page
directories and last level Page table).

But yes, we have to look into concurrency once we have channels, and users other
than bar where have multiple users of the same address space doing
mapping/unmapping.

I think we can incrementally build on this series to add support for the same,
it is not something this series directly addresses since I have spend majority
of my time last several months making translation *work* which is itself no east
task. This series is just preliminary based on work from last several months and
to make BAR1 work. For instance, I kept PRAMIN simple based on feedback that we
don't want to over complicate without fully understanding all the requirements.
There is also additional requirements for locking design that have implications
with DMA fencing etc, for instance.

Anyway thinking out loud, I am thinking for handling concurrency at the page
table entry level (if we ever need it), we could use per-PT spinlocks similar to
the Linux kernel. But lets plan on how to do this properly and based on actual
requirements.

-- 
Joel Fernandes

