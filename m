From: Dan Carpenter <dan.carpenter@oracle.com>
Date: Fri, 19 Jun 2015 10:29:13 +0000
Subject: Re: doubt about sm7xxfb (was: Re: [PATCH v4 0/7] staging: fsl-mc: New functionality to the MC bus dr
Message-Id: <20150619102913.GE30834@mwanda>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1433887148-2310-1-git-send-email-German.Rivera@freescale.com>
 <20150613001849.GB5234@kroah.com>
 <20150613084618.GA6492@sudip-PC>
In-Reply-To: <20150613084618.GA6492@sudip-PC>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Cc: Greg KH <gregkh@linuxfoundation.org>, devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org, tomi.valkeinen@ti.com, linux-fbdev@vger.kernel.org

On Sat, Jun 13, 2015 at 02:16:18PM +0530, Sudip Mukherjee wrote:
>
> can you please have a look (when you are free) at it to see if anything
> else needs to be done.

Remove any unused macros.
Cleanup indenting in the .h file.
drivers/staging/sm7xxfb/sm7xxfb.c:821 smtcfb_pci_probe() warn: 'smtc_regbaseaddress' can't be NULL.
move the BIG_ENDIAN ifdefs to the .h file.  I don't understand why only
big endian systems get a fb_read/write?  Cleanup casts in fb_read/write.
cleanup comments.  make sure they are up to date and make sense.
cleanup function declarations.  Make the style consistent.
run checkpatch.pl --strict
Remind me we need the #ifndef MODULE?

regards,
dan carpenter

