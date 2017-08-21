From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Date: Mon, 21 Aug 2017 14:35:53 +0000
Subject: Re: [PATCH] video: fbdev: udlfb: Fix use after free on dlfb_usb_probe error path
Message-Id: <11058144.rdDtSpvBf3@amdc3058>
List-Id: <linux-fbdev.vger.kernel.org>
References: <CGME20170811125917epcas4p1201e8047f04655c0cade9d0b92c0fd30@epcas4p1.samsung.com>
        <1502456341-1783-1-git-send-email-vasilyev@ispras.ru>
In-Reply-To: <1502456341-1783-1-git-send-email-vasilyev@ispras.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Anton Vasilyev <vasilyev@ispras.ru>
Cc: Bernie Thompson <bernie@plugable.com>, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, ldv-project@linuxtesting.org

On Friday, August 11, 2017 03:59:01 PM Anton Vasilyev wrote:
> If dlfb_usb_probe drops to error path then there is only one
> kref_init() call and no kref_get(), so second kref_put() leads to
> use after free.
> 
> The patch removes superfluous kref_put on dlfb_usb_probe error path.
> 
> Found by Linux Driver Verification project (linuxtesting.org).
> 
> Signed-off-by: Anton Vasilyev <vasilyev@ispras.ru>

Patch queued for 4.14, thanks.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

