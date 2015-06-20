From: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Date: Sat, 20 Jun 2015 11:32:06 +0000
Subject: Re: doubt about sm7xxfb (was: Re: [PATCH v4 0/7] staging: fsl-mc: New functionality to the MC bus dr
Message-Id: <20150620112006.GD29626@sudip-PC>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1433887148-2310-1-git-send-email-German.Rivera@freescale.com>
 <20150613001849.GB5234@kroah.com>
 <20150613084618.GA6492@sudip-PC>
 <20150619102913.GE30834@mwanda>
In-Reply-To: <20150619102913.GE30834@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: Greg KH <gregkh@linuxfoundation.org>, devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org, tomi.valkeinen@ti.com, linux-fbdev@vger.kernel.org

On Fri, Jun 19, 2015 at 01:29:13PM +0300, Dan Carpenter wrote:
> On Sat, Jun 13, 2015 at 02:16:18PM +0530, Sudip Mukherjee wrote:
> >
> > can you please have a look (when you are free) at it to see if anything
> > else needs to be done.
> 
> Remove any unused macros.
I will check.
> Cleanup indenting in the .h file.
done.
> drivers/staging/sm7xxfb/sm7xxfb.c:821 smtcfb_pci_probe() warn: 'smtc_regbaseaddress' can't be NULL.
i dont see this warning. Is it smatch?
> move the BIG_ENDIAN ifdefs to the .h file.  I don't understand why only
> big endian systems get a fb_read/write?
Greg asked to remove the BIG_ENDIAN ifdefs. for BIG_ENDIAN some
calculations are involved that is why the functions are defined.
LITTLE_ENDIAN will use the default read/write provided by fb core.
> cleanup comments.  make sure they are up to date and make sense.
will do.
> cleanup function declarations.  Make the style consistent.
i think its already done, with Joe's help.
> run checkpatch.pl --strict
done.
> Remind me we need the #ifndef MODULE?
This one I introduced with the plan that if it is built-in then it will
use the commandline to get the mode, but if it is a module then it will
use module parameters. But later Greg told that framebuffers should not
use module_param. I dont see any reason why a module can nor get the mode
values from the command line. I will test that during this period of the
merge window and prepare the final patch.

regards
sudip
--
To unsubscribe from this list: send the line "unsubscribe linux-fbdev" in
