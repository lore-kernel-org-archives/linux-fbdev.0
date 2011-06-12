From: Maarten Lankhorst <m.b.lankhorst@gmail.com>
Date: Sun, 12 Jun 2011 17:48:10 +0000
Subject: Re: [PATCH] efifb: Fix call to wrong unregister function
Message-Id: <BANLkTimXALxHwNMSODXujT4pT-C+m3rcaQ@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1307875953.1859.6.camel@Tux>
In-Reply-To: <1307875953.1859.6.camel@Tux>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "wanlong.gao" <wanlong.gao@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org, Peter Jones <pjones@redhat.com>

Hey,

2011/6/12 wanlong.gao <wanlong.gao@gmail.com>:
> <snip>
>
> Hi Maarten:
> It registered efifb_device but try to unregistered efifb_driver,
> so I think you should fix it like this?
Ah yes, that seems to be the correct one, platform_driver_register was
removed. Not 100% sure if acked by or signed-off-by is appropriate
here.

Signed-off-by: Maarten Lankhorst <m.b.lankhorst@gmail.com>

~Maarten
