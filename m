From: Luc Verhaegen <libv@skynet.be>
Date: Thu, 14 Aug 2014 10:42:08 +0000
Subject: Re: [PATCH 2/4] simplefb: add goto error path to probe
Message-Id: <20140814104208.GB1000@skynet.be>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1407914239-12054-1-git-send-email-libv@skynet.be>
 <1407914239-12054-3-git-send-email-libv@skynet.be>
 <CANq1E4Tsi6-a5wL8=SFZuX=+K68txAzp-WBjLSM+ZhW+k4tMfg@mail.gmail.com>
 <20140814102940.GA1000@skynet.be>
 <CANq1E4TAf=Lyuz5psPJE+MWyUO8db8V+-BqXmVyvdLvmY5g=iQ@mail.gmail.com>
In-Reply-To: <CANq1E4TAf=Lyuz5psPJE+MWyUO8db8V+-BqXmVyvdLvmY5g=iQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Thu, Aug 14, 2014 at 12:33:55PM +0200, David Herrmann wrote:
> Hi
> 
> I'd skip the leading whitespace and the newlines, like this:
> 
> +error_unmap:
> +        iounmap(info->screen_base);
> +error_fb_release:
> +        framebuffer_release(info);
> +        return ret;
> 
> at least that's my conception how we format error paths in drivers/video/.

Will do. Thanks.

Luc Verhaegen.
