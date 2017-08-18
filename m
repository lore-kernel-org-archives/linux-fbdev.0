From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Date: Fri, 18 Aug 2017 17:49:26 +0000
Subject: Re: [PATCH] video: fbdev: add const to bin_attribute structures
Message-Id: <11839540.IE8C3lnAOm@amdc3058>
List-Id: <linux-fbdev.vger.kernel.org>
References: <CGME20170802171007epcas3p1b03e51adbcbd3f6b1396b313a6d0873f@epcas3p1.samsung.com>
        <1501693795-13090-1-git-send-email-bhumirks@gmail.com>
In-Reply-To: <1501693795-13090-1-git-send-email-bhumirks@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Bhumika Goyal <bhumirks@gmail.com>
Cc: julia.lawall@lip6.fr, bernie@plugable.com, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

On Wednesday, August 02, 2017 10:39:55 PM Bhumika Goyal wrote:
> Add const to bin_attribute structures as they are only passed to the
> functions sysfs_{remove/create}_bin_file or
> device_{remove/create}_bin_file. The corresponding arguments are of
> type const, so declare the structures to be const.
> 
> Signed-off-by: Bhumika Goyal <bhumirks@gmail.com>

Patch queued for 4.14, thanks.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

