From: Timur Tabi <timur@tabi.org>
Date: Sun, 17 Mar 2013 23:09:09 +0000
Subject: Re: [PATCH] drivers/video: fsl-diu-fb: add hardware cursor support
Message-Id: <CAOZdJXU2adcGvhbe0twkg=optqnGu4-RyVFDRA6iJrcGQAY9rw@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1358281046-31552-1-git-send-email-timur@tabi.org>
In-Reply-To: <1358281046-31552-1-git-send-email-timur@tabi.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

On Tue, Jan 15, 2013 at 2:17 PM, Timur Tabi <timur@tabi.org> wrote:
> From: Timur Tabi <timur@freescale.com>
>
> The Freescale DIU supports a 32x32 color hardware cursor.  Framebuffer
> cursors are monochrome, so the driver converts the image data to the
> format that the DIU expects and then programs to hardware accordingly.
>
> The support cursor enabling/disabling, we provide two cursor image buffers.
> One is always blank (all zeroes), and the other contains the real cursor
> image data.  To disable the cursor (used typically for cursor blinking),
> we just tell the hardware to use the blank cursor data.
>
> Signed-off-by: Timur Tabi <timur@freescale.com>

Florian, this patch was posted a month before the 3.9 merge window
opened.  Is there any chance it will still get into 3.9?

-- 
Timur Tabi
Linux kernel developer at Freescale
