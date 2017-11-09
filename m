From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Date: Thu, 09 Nov 2017 15:10:26 +0000
Subject: Re: [PATCH 1/3] sm501fb: deallocate colormap only if allocated
Message-Id: <302068430.vB7nQmsVoE@amdc3058>
List-Id: <linux-fbdev.vger.kernel.org>
References: <CGME20171104212429epcas1p428cc1efb505e9c78dda41e603c400b7b@epcas1p4.samsung.com>
        <1509830661-7384-1-git-send-email-sudipm.mukherjee@gmail.com>
In-Reply-To: <1509830661-7384-1-git-send-email-sudipm.mukherjee@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org

On Saturday, November 04, 2017 09:24:19 PM Sudip Mukherjee wrote:
> There are cases when panel and crt both are not defined and only one of
> them is defined and initialized. In such cases, while removing the
> device deallocate the colormap only if that particular fb is defined.
> 
> Signed-off-by: Sudip Mukherjee <sudipm.mukherjee@gmail.com>

Patch queued for 4.15, thanks.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

