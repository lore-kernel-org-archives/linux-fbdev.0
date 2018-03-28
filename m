From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Date: Wed, 28 Mar 2018 13:42:44 +0000
Subject: Re: [PATCH v2 1/2] video: udlfb: Return an error code only as a constant in dlfb_realloc_framebuffer
Message-Id: <60893411.8iluP6siGW@amdc3058>
List-Id: <linux-fbdev.vger.kernel.org>
References: <CGME20171124204825epcas1p41626d598b6e437dfb4c6b648e3730cc1@epcas1p4.samsung.com>
 <25aee051-12fb-de5f-c806-f419fa4c0ef1@users.sourceforge.net>
 <632abf1e-8c40-cbd2-4bbe-5dfdf89cb95f@users.sourceforge.net>
In-Reply-To: <632abf1e-8c40-cbd2-4bbe-5dfdf89cb95f@users.sourceforge.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: SF Markus Elfring <elfring@users.sourceforge.net>
Cc: linux-fbdev@vger.kernel.org, kernel-janitors@vger.kernel.org, Bernie Thompson <bernie@plugable.com>, dri-devel@lists.freedesktop.org, LKML <linux-kernel@vger.kernel.org>

On Sunday, January 07, 2018 02:34:51 PM SF Markus Elfring wrote:
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Sun, 7 Jan 2018 14:02:36 +0100
> 
> * Return an error code without storing it in an intermediate variable.
> 
> * Delete the label "error" and local variable "retval"
>   which became unnecessary with this refactoring.
> 
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>

Patch queued for 4.17, thanks.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

