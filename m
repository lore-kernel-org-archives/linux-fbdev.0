From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Date: Wed, 14 Jun 2017 14:48:47 +0000
Subject: Re: [PATCH] video: fbdev: pxafb:  Handle return value of clk_prepare_enable
Message-Id: <3453913.nT1TzBXoXS@amdc3058>
List-Id: <linux-fbdev.vger.kernel.org>
References: <CGME20170607095229epcas3p1730b65f2db44accc1f7b950d2265bb19@epcas3p1.samsung.com>
        <5e0ce70b74924acc351ce4d8ef846c28f8e6ceda.1496829008.git.arvind.yadav.cs@gmail.com>
In-Reply-To: <5e0ce70b74924acc351ce4d8ef846c28f8e6ceda.1496829008.git.arvind.yadav.cs@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Arvind Yadav <arvind.yadav.cs@gmail.com>
Cc: linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

On Wednesday, June 07, 2017 03:22:09 PM Arvind Yadav wrote:
> clk_prepare_enable() can fail here and we must check its return value.
> 
> Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>

Patch queued for 4.13, thanks.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

