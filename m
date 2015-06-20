From: Juston Li <juston.h.li@gmail.com>
Date: Sat, 20 Jun 2015 05:49:47 +0000
Subject: Re: [PATCH v2] staging: sm750fb: use tabs for indentation
Message-Id: <CAFow2F8=tP1E08UWcr2y7NWnqXmAJy2-jOjz8VemtJd8__TE4w@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1434777191-16946-1-git-send-email-juston.h.li@gmail.com>
	<20150620052131.GA21984@kroah.com>
In-Reply-To: <20150620052131.GA21984@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Sudip Mukherjee <sudipm.mukherjee@gmail.com>, teddy.wang@siliconmotion.com, linux-fbdev@vger.kernel.org, devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org

On Fri, Jun 19, 2015 at 10:21 PM, Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Fri, Jun 19, 2015 at 10:13:11PM -0700, Juston Li wrote:
> > Replace spaces with tabs for indentation to fix the checkpatch.pl warning
> > 'WARNING: please, no spaces at the start of a line'
> >
> > checkpatch doesn't catch comments indented by spaces but I fixed comments
> > adjacent to warnings as well so they would remain aligned.
> >
> > Changes since v1:
> > fix alignment in ddk750_display.c:154
> > didn't remove a space in ddk750_hwi2c.c:48
>
> The version info here should go below the --- line, so it doesn't show
> up in the changelog itself.
>
> third time's a charm?

Thanks for the tip, resent as v3.

*cross fingers*

Regards
Juston
--
To unsubscribe from this list: send the line "unsubscribe linux-fbdev" in
