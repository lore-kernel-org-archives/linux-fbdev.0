From: Scot Doyle <lkml14@scotdoyle.com>
Date: Wed, 29 Jun 2016 13:55:34 +0000
Subject: Re: [RFC PATCH kernel] Revert "fbcon: use the cursor blink interval provided by vt"
Message-Id: <alpine.DEB.2.10.1606290837370.6296@laptop>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1467188352-5580-1-git-send-email-aik@ozlabs.ru>
In-Reply-To: <1467188352-5580-1-git-send-email-aik@ozlabs.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

On Wed, 29 Jun 2016, Alexey Kardashevskiy wrote:
> On 29/06/16 18:31, Benjamin Herrenschmidt wrote:
> > On Wed, 2016-06-29 at 18:29 +1000, Benjamin Herrenschmidt wrote:
> >> On Wed, 2016-06-29 at 18:19 +1000, Alexey Kardashevskiy wrote:
> >>> This is rather a bugreport than actual revert but nevertheless.
> >>>
> >>> Since 27a4c827c34a I started noticing weird traces and quite often
> >>> I could not boot my test machine which is POWER8 box with AST video
> >>> or ATI video (video adapter type does not matter much although
> >>> is happens lot more often with the OpenPOWER machine which got
> >>> AST).
> >>> The system console is IPMI, not the actual video adapter.
> >>>
> >>> I bisected it to this:
> >>>
> >>> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/com
> >>> mi
> >>> t/?id'a4c827c34ac4256a190cc9d24607f953c1c459
> >>>
> >>> For some reason which I do not understand, in
> >>> cursor_timer_handler(),
> >>> ops->cur_blink_jiffies is zero. Why can this happen? What is a
> >>> proper
> >>> fix? Thanks.
> >>
> >> Rings a bell... do you have fbcon: initialize blink interval before
> >> calling fb_set_par (f235f664a8afabccf863a5dee4777d2d7b676fda) ?
> > 
> > Also check if you have:
> > 
> > "fbcon: set a default value to blink interval"
> > (upstream ID a1e533ec07d583d01349ef13c0c965b8633e1b91).
> 
> 
> Yes, both. The problem I see appears from v4.4 till the very recent
> upstream kernel which I am debugging now and which is v4.7-rc5.

Hi Alexey,

Have you tried commit 1b45996d2ebf "tty: vt: Fix soft lockup in 
fbcon cursor blink timer." from the tty-linus branch of Greg's tty tree?

Or if that doesn't work, then perhaps
"fbcon: warn on invalid cursor blink intervals" from 
http://thread.gmane.org/gmane.linux.kernel.stable/178675/focus"26587 ?

Thanks,
Scot
