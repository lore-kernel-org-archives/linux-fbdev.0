From: Sedat Dilek <sedat.dilek@googlemail.com>
Date: Fri, 17 Jun 2011 07:15:11 +0000
Subject: Re: [PATCH] gx1fb: Fix section mismatch warnings
Message-Id: <BANLkTims+Zz4EuP+NMKm4qEB_Ldp8nc2Ww@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1294018289-3911-1-git-send-email-sedat.dilek@gmail.com>
	<20110106063906.GB15340@linux-sh.org>
	<20110616123119.6ca873fa.randy.dunlap@oracle.com>
In-Reply-To: <20110616123119.6ca873fa.randy.dunlap@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Randy Dunlap <randy.dunlap@oracle.com>
Cc: Paul Mundt <lethal@linux-sh.org>, linux-geode@lists.infradead.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

On Thu, Jun 16, 2011 at 9:31 PM, Randy Dunlap <randy.dunlap@oracle.com> wrote:
> On Thu, 6 Jan 2011 15:39:07 +0900 Paul Mundt wrote:
>
>> The problem seems to be because gx1fb_probe is annotated __init. In the
>> PCI case you want it to be __devinit, and you're also going to want to
>> annotate the remove function as __devexit and wrap it up with a
>> __devexit_p().
>> --
>
> From: Randy Dunlap <randy.dunlap@oracle.com>
>
> Fix a chain of section mismatches in geode driver, beginning with:
>
> WARNING: drivers/video/geode/gx1fb.o(.data+0x70): Section mismatch in reference from the variable gx1fb_driver to the function .init.text:gx1fb_probe()
> The variable gx1fb_driver references
> the function __init gx1fb_probe()
> If the reference is valid then annotate the
> variable with __init* or __refdata (see linux/init.h) or name the variable:
> *_template, *_timer, *_sht, *_ops, *_probe, *_probe_one, *_console
>
> Making the changes that Paul pointed out resulted in a few more
> changes being needed, so they are all included here.
>
> Signed-off-by: Randy Dunlap <randy.dunlap@oracle.com>
> ---

Hi Randy,

thanks for taking care of this old issue!
It's around a week I did not compile a linux-next kernel.
I should again enable full section mismatch in my setup.

Regards,
- Sedat -
