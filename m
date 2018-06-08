From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Date: Fri, 08 Jun 2018 16:21:51 +0000
Subject: Re: [PATCH 2/3] goldfish: Enable ACPI-based enumeration for goldfish framebuffer
Message-Id: <52712411.e9Q6i9LxU2@amdc3058>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20180531220252.58679-1-rkir@google.com>
 <CGME20180531220437epcas3p4a16627f3bfdfcf6f1d0629bb613374d0@epcas3p4.samsung.com>
 <20180531220252.58679-2-rkir@google.com>
In-Reply-To: <20180531220252.58679-2-rkir@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: rkir@google.com
Cc: linux-fbdev@vger.kernel.org, Yu Ning <yu.ning@intel.com>, dri-devel@lists.freedesktop.org


[ + linux-fbdev ML ]

Hi,

On Thursday, May 31, 2018 03:02:51 PM rkir@google.com wrote:
> From: Yu Ning <yu.ning@intel.com>
> 
> Follow the same way in which ACPI was enabled for goldfish battery. See
> commit d3be10e for details.

No commit d3be10e in upstream and -next kernels?

> Note that this patch also depends on commit af33cac.

ditto for commit af33ac

also commits should be described with the following format:

tag with the first 12 characters of the SHA-1 ID, and the one line summary,
i.e.:

e21d2170f366 ("video: remove unnecessary platform_set_drvdata()")

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

