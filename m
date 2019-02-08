From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Date: Fri, 08 Feb 2019 17:07:39 +0000
Subject: Re: [PATCH] video: fbdev: geode: remove ifdef OLPC noise
Message-Id: <e15a710e-2dc6-8470-2f9a-ecb3124a86a4@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <CGME20190116151558epcas4p11c6468321ddbc3a8b32f03bb627cd560@epcas4p1.samsung.com>
        <20190116151453.1971999-1-lkundrak@v3.sk>
In-Reply-To: <20190116151453.1971999-1-lkundrak@v3.sk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Lubomir Rintel <lkundrak@v3.sk>
Cc: linux-geode@lists.infradead.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org


On 01/16/2019 04:14 PM, Lubomir Rintel wrote:
> <asm/olpc.h> provides olpc_has_dcon() stub for CONFIG_OLPC=n, compiler
> should just optimize the unneeded bits away.
> 
> Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>

Patch queued for v5.1, thanks.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
