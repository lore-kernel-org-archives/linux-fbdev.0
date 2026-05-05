Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCE382EC54C
	for <linux-fbdev@vger.kernel.org>; Tue,  5 May 2026 09:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777974659; cv=none; b=lvJ6wgW7DhF2p7lC6JJY3yKJj0966uCF0k2vV6UG9P+ttF7UcCsPB9A/AP64stCoTG1Dy/4qYjhbSLZ7lamtWmxYQ3ciOz321H/EmKAz6VxnF7O6J1AzlYQmJn7xTIMRWOD1rgATZ9EO09IDsi5zDVc0aKEHfrw7sK8C+tuIMqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777974659; c=relaxed/simple;
	bh=tB0cuSXyWCVCcvCFqY9uCBKVk4Q/akucpHw1mtC7pLU=;
	h=Message-ID:Date:MIME-Version:From:To:Cc:Subject:Content-Type; b=s4f5v8PwgKBwMY87OPkJJjVJt2CEvFAPZL+AzTGqCRv9d6EdJA9pHuhq/784mq2UVDgpxCVCJJQdTrCbaytXEcZNhVNXmiU4UqpFxtgj3Gzzq1aSQTlNsDzPXubLIcPNvmeSFbuq7FczwFXrosey5S/ZVGAhx8NkqnEkJzsUcRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Nw8kl+tQ; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=a86XdoWn; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Nw8kl+tQ";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="a86XdoWn"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6458avOb3409328
	for <linux-fbdev@vger.kernel.org>; Tue, 5 May 2026 09:50:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=tB0cuSXyWCVCcvCFqY9uCB
	KVk4Q/akucpHw1mtC7pLU=; b=Nw8kl+tQ7P5mhnuBW7lsALbsrmqw7Pz6NjQRtr
	yQ6PWTQtHiInrEehM2XKD60EeSTSK67mECBtV0gAOQsgu94UnQw/FN5fZ+XgSjI5
	DZnlRY4TQVpfas99sNRmAIiPy3VV7N8M8bqhopT8Attq5TfnZbZ8lhVXHswxMa0g
	kCZOt6t96kr3Iil7OYo6xypoFfZbb4IdJjPCdVTbPv/2YE1JbP2GmWD2mlngKrP5
	c4aC8d/hzfZLEiey11i5dM2VhDg3tPsTqOwj2B/VX0SX2jw17pDg8d8sy44ulhY/
	TqtCiOS7Vm714uIHzNVYIPlxYOuiFIBUzs7lDEprdAiYSqOg==
Received: from mail-vs1-f72.google.com (mail-vs1-f72.google.com [209.85.217.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dxx00uda9-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-fbdev@vger.kernel.org>; Tue, 05 May 2026 09:50:56 +0000 (GMT)
Received: by mail-vs1-f72.google.com with SMTP id ada2fe7eead31-62f2e4b2b6bso3109276137.1
        for <linux-fbdev@vger.kernel.org>; Tue, 05 May 2026 02:50:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1777974656; x=1778579456; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:cc:to:content-language:from
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tB0cuSXyWCVCcvCFqY9uCBKVk4Q/akucpHw1mtC7pLU=;
        b=a86XdoWnJSsBtx37uAzSMTGxMEGf6xw8QMEalRs8SzQuci69G6wjApIrdr39Xl1vxO
         dF3+gwnNZk7OJlifRr2ENOTSvybTLCFyQZRx67FMs2LvlJWYhLPvJHd6+TEIjAd+ZsA8
         4KpzEKUqDoSpQLhxmSlRX334Lt4Kno206YZF98AhUlQqOrgu7eFtXkZuV9g+uip4iviZ
         jZfYDtm2H96llbaClIdBQVXH42KEDAHqAgQeFJ3CiLxkvGRilvwSJXGznOGEiwcu2PdK
         WS7c8pz6Yl9qv3WjO6rvJR/Z5HzUjSsu4zZv1yJnaCnjkmS1nM5RwgmjMoyCFG7HAO4f
         92Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777974656; x=1778579456;
        h=content-transfer-encoding:subject:cc:to:content-language:from
         :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tB0cuSXyWCVCcvCFqY9uCBKVk4Q/akucpHw1mtC7pLU=;
        b=nOsInmN7HxQI6DJ72vkgtFCX+wGh3RaaKg3LN5UCQNbu8eC6XZUF7/cujBHsXZM27Y
         1Nn7hyoXVTwaW+EVqaWakyzzgo0UplRzwiRSnH60TrFHGJ9dl7iOc4gEv3MXBmUH0It9
         AIjnE9jRUjg0wswPkNFM3zn+tGnbzx5Canodz8hKHz28DkbS1FHiDxl/CW5w3/GaZXy/
         OFJsIdX6Kyo1UfgIBKz1YJHtHWd0z2LbkKEabgABW7crspnguFHMwB0/Mrv+R6unV4xV
         XycEYvz2Kfn3HEw8+hrpzVZ5OYrQn8KfZsRnK4C9Ak+bCA4QOZVwjWOKzobIwKps3BFq
         6HJw==
X-Forwarded-Encrypted: i=1; AFNElJ9iVi1IIVQPDUqkgMn4917y7KMM1XhGyYcJLNrooDc7OeGlYJRX85oag/AYoVeYl2pYKbER/hjwhfBPSQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yye/LdFlOz87aOQymm2DtZCVrwRvh/TUVSuSCU4bVtOu8X4OWxX
	k1p9IgliV8SX2f/KeCd5NPaiq1nXPBHRzmwYVsa0dZ8QB321P1fWHh/Zaq08DSExYBWR8FUUf11
	5h72Bz78nh8oDZFPjjFnXQKlf9eHsT+7AgrUys7fIVSAXF5Wye9ohk94WzcCjOAXH9w==
X-Gm-Gg: AeBDietofiuJRX/qt0Z7q9SvgA8we5KTMZFKKS2lkQI72HD5ok5oN37kp9dulwqJBVx
	TFliUkr9fYKjshdwtbpfPFzo/4K4sGm82NV0RgV3XOR6ccn3KXi1K4aQu8wdg6UD66i9BvQSREo
	zSwoA5uokIFyYxMYN8A/QlowL1zG+GikO+87m0iD4BgYQp/kovDbac0MDyasDP9oLhpk+XyV5K2
	OIuorGz/zDyKaf69gHsTUKhjSlBiytuOJMUoq0XfHxh0W18hIGM5A0h6tz7sbK5MlXwNjUPU7ai
	qFFeIbmZBN71mTzLAa/erkpeJ2X2cPvIA88BDCu6ZDKmCAFdYHEefjNiIb9UdfZv6WWKt/abIH9
	K88Hcc/0i+WKN9Hc1PuqecNKlS3U2EgD/rCjP0z94nPJqNQXUZTN+rn9SrS7TV5mJdmRfyGexXz
	IGq/136JSwNHxRLjKmCNQ2io4Oo4Gswm3jK49sNua8gulPK2TpjEMi/hSTJeu2Zna6zZCRDzgqT
	Vh/AiIEDWgaoK+mvYEuEutByqE=
X-Received: by 2002:a05:6102:8009:b0:62f:3326:fa4c with SMTP id ada2fe7eead31-62f55a5d6c0mr1245352137.21.1777974655717;
        Tue, 05 May 2026 02:50:55 -0700 (PDT)
X-Received: by 2002:a05:6102:8009:b0:62f:3326:fa4c with SMTP id ada2fe7eead31-62f55a5d6c0mr1245348137.21.1777974655324;
        Tue, 05 May 2026 02:50:55 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bc1b97a11easm219088766b.44.2026.05.05.02.50.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 May 2026 02:50:54 -0700 (PDT)
Message-ID: <b8b4fc94-6aae-4558-a4bb-13c26cae186f@oss.qualcomm.com>
Date: Tue, 5 May 2026 11:50:53 +0200
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Hans de Goede <johannes.goede@oss.qualcomm.com>
Content-Language: en-US, nl
To: Lee Jones <lee@kernel.org>, Daniel Thompson <danielt@kernel.org>,
        Jingoo Han <jingoohan1@gmail.com>, Helge Deller <deller@gmx.de>,
        Daniel Dadap <ddadap@nvidia.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc: "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        linux-fbdev@vger.kernel.org, linux-acpi <linux-acpi@vger.kernel.org>
Subject: Plan to fix nvidia_wmi_ec backlight issues, help wanted
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=APflyhIR c=1 sm=1 tr=0 ts=69f9bd80 cx=c_pps
 a=DUEm7b3gzWu7BqY5nP7+9g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=VwQbUJbxAAAA:8
 a=GHR8O2WEAAAA:20 a=e5mUnYsNAAAA:8 a=iox4zFpeAAAA:8 a=FQzLeyTS56HO1ZxThNwA:9
 a=QEXdDO2ut3YA:10 a=-aSRE8QhW-JAV6biHavz:22 a=Vxmtnl_E_bksehYqCbjh:22
 a=WzC6qhA0u3u7Ye7llzcV:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA1MDA5MiBTYWx0ZWRfX1H6nUXu8rUNq
 86dKYZTdjaWfBB6R8UN9Pi4/Gx7Tosam7wAs89wcLbCyRtLbPjCgBu1IjV3RG1NZdhSz0IfCCKR
 1YuhHXwXotOkBYNIlF4jpXp89yKJZ9j4IG/A1FFvapMxI+SwwKih4VYX6dKS3OeBOBATykGho4B
 UfVwuM9ssG9+5k3XwPFxX9gRRv2ZKeUh7kPLN5Dezx3YtICMgNC07azj2AOXL4ISIMH1FPlV8cI
 hjVe65Aju54iIr2QIdcH6/vCgtdRFgPYjC6BVFtknHzvYwBY5bb+Z1Hb2fbvBgcoluHqufrYGVy
 N0etSY5cCjY36OrX0fuHp+MJ6WdIItyh9Jldjxf8kY5+u1JqVfomP1leVE4H9mFiE7nSYVcQeMl
 AARSGaLNFR1XSHMDKZbqjsnqjUtecxFdBk0rZUoX5R2E6GSAo0F7MO06CiMuAionZmKP+oo3PUl
 ZNSSK0EhR3jL9vWc5Ow==
X-Proofpoint-GUID: z_l53yfqXP5yAOoe8-NM7vWfSFiNozpP
X-Proofpoint-ORIG-GUID: z_l53yfqXP5yAOoe8-NM7vWfSFiNozpP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-05_02,2026-04-30_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1011 impostorscore=0 spamscore=0 phishscore=0
 lowpriorityscore=0 malwarescore=0 adultscore=0 suspectscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2605050092

Hi All,

A while ago Nvidia introduced a new Nvidia specific firmware method
for controlling the backlight on laptops with runtime switchable
Nvidia hybrid graphics.

This is supported through the nvidia-wmi-ec-backlight driver, but has
never worked 100%.

The new WMI firmware interface has a method to ask the firmware if
the backlight is controlled though the EC and this the new WMI interface
should be used; or if it is directly controlled by the GPU and the GPU
driver's native backlight support should be used.

There are several bugs in the implementation of this on various laptops:

1. The method to get the backlight control source sometimes does not
report the correct value.

2. On some laptop models which method (native-gpu vs nvidia-wmi) works
changes at runtime, e.g. when plugging in a charger.

Known affected laptop models/bug reports about this:
- Acer Predator PH315-55: needs acpi_backlight=native
- Dell G15 5515 with RTX 3050: *needs* acpi_backlight=native
- Dell G15 5515 with RTX 3060: *breaks* with acpi_backlight=native
- Lenovo Legion Slim 7 2021
- https://bugzilla.kernel.org/show_bug.cgi?id=217026
- https://gitlab.gnome.org/GNOME/gnome-settings-daemon/-/work_items/784
- https://gitlab.freedesktop.org/drm/amd/-/issues/4512
- https://bugzilla.suse.com/show_bug.cgi?id=1217750

It turns out that under Windows both a WMI backlight driver and a GPU
native backlight driver get installed and Windows simply always calls
both when the backlight changes working around these kind of firmware
bugs.

When this first came up, about 2 years ago, I came up with the below
plan to fix this. Nvidia was supposed to work in implementing this,
but so far an implementation of this plan has not happened.

Note I do not have time to work on this myself. I'm posting this here
in the hope that either Nvidia will pick this up after all; or that
someone else can make this happen.

I'm more then happy to help answering any questions which may come up
while implementing this; and to review the resulting patches.


The plan
========

1. Modify the core backlight code to allow registering a backlight-device
for in kernel use only, disabling the registering of a class device under
/sys/class/backlight .

2. Add a new backlight-aggregate.c backlight driver, which exports a
devm_backlight_aggregate_register_or_add() function. Drivers can call
this passing in an existing backlight-device (with its sysfs interface
disabled). This either creates a singleton /sys/class/backlight/aggregate
device, or adds the passed in backlight to the existing singleton instance
if it already exists.

This new driver always exposes a range of 0-255 to userspace. This acts
as a proxie for any backlight-devices registered to be part of
the aggregate, forwarding any brightness set calls to all backlights,
scaled to their actual range. For reads this will report the last set
brightness value (starting with the value of the first registered
backlight-device).

3. Add a new nvidia_wmi_ec_and_native type to drivers/acpi/video_detect.c
for both DMI quirks and commandline handling.

4. Modify acpi_video_backlight_use_native() to also return true if
the __acpi_video_get_backlight_type() call there returns the new
acpi_backlight_nvidia_wmi_ec_and_native.

5. Add a new devm_backlight_device_register_native() helper which
calls __acpi_video_get_backlight_type(true, NULL) and if that returns
the new nvidia_wmi_ec_and_native type then registers the passed in
backlight with the flag to not register a sysfs class interface and
then on success calls the new devm_backlight_aggregate_register_or_add()
with the just registered backlight device; and if the returned type
instead is acpi_backlight_native register the passed in backlight
normally through devm_backlight_device_register()

5. Modify the i915 and amdgpu drivers to use the new
devm_backlight_device_register_native() helper. Since this new helper
checks the backlight-type itself, drop acpi_video_backlight_use_native()
checks *if* the registration is the only thing guarded by that check.

6. drivers/platform/x86/nvidia-wmi-ec-backlight.c to not return
early from probe when acpi_video_get_backlight_type() returns
the new nvidia_wmi_ec_and_native type and for that type make it
registers its backlight with the flag to not register a sysfs class
interface and then on success calls the new
devm_backlight_aggregate_register_or_add().

Regards,

Hans

