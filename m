From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Date: Tue, 24 Jul 2018 15:11:30 +0000
Subject: Re: [PATCH] video: fbdev: fsl-diu-fb: Remove VLA usage
Message-Id: <30654789.W1eWMCegYZ@amdc3058>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20180629184655.GA37391@beast>
 <CGME20180630155937epcas3p391d051b484a76fb57f0c385a89e2be04@epcas3p3.samsung.com>
 <1b3f78f2-9fe9-62c5-24d2-1b6651ca2f08@kernel.org>
In-Reply-To: <1b3f78f2-9fe9-62c5-24d2-1b6651ca2f08@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Timur Tabi <timur@kernel.org>, Kees Cook <keescook@chromium.org>
Cc: linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org

On Saturday, June 30, 2018 10:59:15 AM Timur Tabi wrote:
> On 6/29/18 1:46 PM, Kees Cook wrote:
> > In the quest to remove all stack VLA usage from the kernel[1], this moves
> > the buffer off the stack (since it could be as much as 1024 bytes), and
> > uses a new area in the cursor data structure. Additionally adds missed
> > documentation and removes redundant assignments.
> > 
> > [1]https://lkml.kernel.org/r/CA+55aFzCG-zNmZwX4A2FQpadafLfEzK6CC=qPXydAacU1RqZWA@mail.gmail.com
> > 
> > Signed-off-by: Kees Cook<keescook@chromium.org>
> 
> Acked-by: Timur Tabi <timur@kernel.org>

Patch queued for 4.19, thanks.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

