From: Tormod Volden <lists.tormod@gmail.com>
Date: Thu, 26 May 2011 14:12:21 +0000
Subject: Re: [PATCH 21/29] s3fb: use display information in info not in var
Message-Id: <BANLkTincNfXaXb-fxTbOvcHvFj+=BkJ2vQ@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1306364301-8195-22-git-send-email-laurent.pinchart@ideasonboard.com>
In-Reply-To: <1306364301-8195-22-git-send-email-laurent.pinchart@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-fbdev@vger.kernel.org

On Thu, May 26, 2011 at 12:58 AM, Laurent Pinchart wrote:
> We must not use any information in the passed var besides xoffset,
> yoffset and vmode as otherwise applications might abuse it. Also use the
> aligned fix.line_length and not the (possible) unaligned xres_virtual.
>
> Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> Cc: Antonino Daplas <adaplas@gmail.com>
> ---
> =A0drivers/video/savage/savagefb_driver.c | =A0 16 +++++++---------
> =A01 files changed, 7 insertions(+), 9 deletions(-)

The patch title is misleading, this is not the s3fb driver but the
savagefb driver.

Tormod
