From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Date: Thu, 09 Nov 2017 15:11:09 +0000
Subject: Re: [PATCH 3/3] sm501fb: suspend and resume fb if it exists
Message-Id: <107894689.9Po6WqHTON@amdc3058>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1509830661-7384-1-git-send-email-sudipm.mukherjee@gmail.com>
        <CGME20171104212431epcas1p2418502fe1cfad971b4239d301460c43b@epcas1p2.samsung.com>
        <1509830661-7384-3-git-send-email-sudipm.mukherjee@gmail.com>
In-Reply-To: <1509830661-7384-3-git-send-email-sudipm.mukherjee@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org

On Saturday, November 04, 2017 09:24:21 PM Sudip Mukherjee wrote:
> There are cases when panel and crt both are not defined and only one of
> them is defined and initialized. In such cases, suspend or resume it
> only if it is defined.
> 
> Signed-off-by: Sudip Mukherjee <sudipm.mukherjee@gmail.com>

Patch queued for 4.15, thanks.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

