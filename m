From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Date: Fri, 28 Jun 2019 10:27:51 +0000
Subject: Re: [PATCH 3/3] video: fbdev: don't print error message on framebuffer_alloc() failure
Message-Id: <4a534d3e-0ce6-9dfd-b3f2-e69aa0a1fcd8@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <3da197ed-a701-2aa7-d775-2bdbe9deab4a@samsung.com>
        <CGME20190628102754eucas1p283e1ad580a242323137a4b6c7024028c@eucas1p2.samsung.com>
In-Reply-To: <3da197ed-a701-2aa7-d775-2bdbe9deab4a@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
Cc: =?UTF-8?Q?Bruno_Pr=c3=a9mont?= <bonbons@linux-vserver.org>, Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>


On 6/14/19 4:51 PM, Bartlomiej Zolnierkiewicz wrote:
> framebuffer_alloc() can fail only on kzalloc() memory allocation
> failure and since kzalloc() will print error message in such case
> we can omit printing extra error message in drivers (which BTW is
> what the majority of framebuffer_alloc() users is doing already).
>=20
> Cc: "Bruno Pr=C3=A9mont" <bonbons@linux-vserver.org>
> Cc: Jiri Kosina <jikos@kernel.org>
> Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>
> Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

I queued the patch for v5.3.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
