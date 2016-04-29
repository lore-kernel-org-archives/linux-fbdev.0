From: Gerd Hoffmann <kraxel@redhat.com>
Date: Fri, 29 Apr 2016 08:02:07 +0000
Subject: Re: [PATCH v3 0/7] drm: Add fbdev deferred io support to helpers
Message-Id: <1461916927.15430.85.camel@redhat.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1461780996-8612-1-git-send-email-noralf@tronnes.org>
In-Reply-To: <1461780996-8612-1-git-send-email-noralf@tronnes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Noralf =?ISO-8859-1?Q?Tr=F8nnes?= <noralf@tronnes.org>
Cc: linux-fbdev@vger.kernel.org, tomi.valkeinen@ti.com, laurent.pinchart@ideasonboard.com, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org

On Mi, 2016-04-27 at 20:16 +0200, Noralf Tr=C3=B8nnes wrote:
> I have also added patches that converts qxl and udl to use this
> deferred io support. I have only compile tested it, no functional
> testing.
> I know that qxl is purely a software thing so I could actually test
> it, but
> I have never used qemu so I'm not keen on spending a lot of time on
> that.

Tested-by: Gerd Hoffmann <kraxel@redhat.com>
