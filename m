From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Date: Tue, 04 Jul 2017 15:00:57 +0000
Subject: Re: [PATCH] video: fbdev: aty: remove useless variable assignments in aty_var_to_crtc()
Message-Id: <30595844.JA8gAC7Mhf@amdc3058>
List-Id: <linux-fbdev.vger.kernel.org>
References: <CGME20170626220521epcas2p21e20ebaf7d36ec6d7a5cd54b81afdb4c@epcas2p2.samsung.com>
        <20170626220518.GA9369@embeddedgus>
In-Reply-To: <20170626220518.GA9369@embeddedgus>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "Gustavo A. R. Silva" <garsilva@embeddedor.com>
Cc: linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

On Monday, June 26, 2017 05:05:18 PM Gustavo A. R. Silva wrote:
> Value assigned to variable vdisplay at line 990 is overwritten
> at line 1039 before it can be used. Also, variable assignment
> at line 987 is the same as at line 1039. This makes such
> variable assignments useless.
> 
> Remove these variable assignments and the code related.
> 
> Addresses-Covertity-ID: 1226900
> Signed-off-by: Gustavo A. R. Silva <garsilva@embeddedor.com>

Patch queued for 4.13, thanks.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

