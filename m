From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Sun, 18 Sep 2011 20:49:35 +0000
Subject: Re: [PATCH v3 0/3] fbdev: Add FOURCC-based format configuration API
Message-Id: <201109182249.39536.laurent.pinchart@ideasonboard.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1314789501-824-1-git-send-email-laurent.pinchart@ideasonboard.com> <4E764B35.2090009@gmx.de>
In-Reply-To: <4E764B35.2090009@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
Cc: linux-fbdev@vger.kernel.org, linux-media@vger.kernel.org, magnus.damm@gmail.com, Mauro Carvalho Chehab <mchehab@redhat.com>

Hi Florian,

On Sunday 18 September 2011 21:49:09 Florian Tobias Schandinat wrote:
> Hi all,
> 
> as there was no reaction to this patch series I am scheduling it for 3.3
> merge window (3.2 seems too close to me as this is an API change).

That's fine with me.

> As the second patch has nothing to do with fbdev it should go mainline via
> V4L2. Any problems/comments?

The NV24/42 patch will need to reach mainline before the sh_mobile_lcdc YUV 
API patch, or compilation will break.

Mauro, what's your preference ? Should the patch go through the media tree ? 
If so, how should we synchronize it with the fbdev tree ? Should I push it to 
3.2 ?

-- 
Regards,

Laurent Pinchart
