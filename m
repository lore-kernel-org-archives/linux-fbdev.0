From: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
Date: Fri, 11 Nov 2011 16:31:13 +0000
Subject: Re: [PATCH v3 0/3] fbdev: Add FOURCC-based format configuration API
Message-Id: <4EBD4DD1.7030809@gmx.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1314789501-824-1-git-send-email-laurent.pinchart@ideasonboard.com> <4E764B35.2090009@gmx.de> <201109182249.39536.laurent.pinchart@ideasonboard.com>
In-Reply-To: <201109182249.39536.laurent.pinchart@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: linux-fbdev@vger.kernel.org, linux-media@vger.kernel.org, magnus.damm@gmail.com, Mauro Carvalho Chehab <mchehab@redhat.com>

On 09/18/2011 08:49 PM, Laurent Pinchart wrote:
>> As the second patch has nothing to do with fbdev it should go mainline via
>> V4L2. Any problems/comments?
> 
> The NV24/42 patch will need to reach mainline before the sh_mobile_lcdc YUV 
> API patch, or compilation will break.
> 
> Mauro, what's your preference ? Should the patch go through the media tree ? 
> If so, how should we synchronize it with the fbdev tree ? Should I push it to 
> 3.2 ?

ping

What's going on? I could carry the patch but I'd want an Ack to do so.


Best regards,

Florian Tobias Schandinat
