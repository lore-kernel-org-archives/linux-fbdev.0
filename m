From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Date: Tue, 01 Aug 2017 13:47:40 +0000
Subject: Re: [PATCH] video: fbdev: Convert to using %pOF instead of full_name
Message-Id: <4331639.hUALxSEUjp@amdc3058>
List-Id: <linux-fbdev.vger.kernel.org>
References: <CGME20170718214516epcas5p41593e7a72c2abb4ab7f78934027679fb@epcas5p4.samsung.com>
        <20170718214339.7774-56-robh@kernel.org>
In-Reply-To: <20170718214339.7774-56-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Rob Herring <robh@kernel.org>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-fbdev@vger.kernel.org

On Tuesday, July 18, 2017 04:43:36 PM Rob Herring wrote:
> Now that we have a custom printf format specifier, convert users of
> full_name to use %pOF instead. This is preparation to remove storing
> of the full path string for each node.
> 
> Signed-off-by: Rob Herring <robh@kernel.org>
> Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> Cc: linux-fbdev@vger.kernel.org

The patch Looks fine to me. Do you want me to merge it through fbdev
tree or do you have some other plan for %pOF conversion patches?

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

