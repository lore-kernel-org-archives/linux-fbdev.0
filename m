From: Andrew Morton <akpm@linux-foundation.org>
Date: Mon, 01 Feb 2010 22:09:32 +0000
Subject: Re: [PATCH/RFC 2.6.33-rc5 1/1] broadsheetfb: support storing
Message-Id: <20100201140932.26fbc1e6.akpm@linux-foundation.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1264395836-9892-1-git-send-email-jayakumar.lkml@gmail.com>
In-Reply-To: <1264395836-9892-1-git-send-email-jayakumar.lkml@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

On Mon,  1 Feb 2010 18:35:08 +0800
Jaya Kumar <jayakumar.lkml@gmail.com> wrote:

> This patch adds the ability to store waveforms to broadsheetfb. It uses the
> firmware class to retrieve the waveform. The request to store the waveform
> is triggered from a driver sysfs entry called loadstore_waveform. I
> considered adding this to Documentation/ABI/testing/ but then decided against
> it. It is not something I would expect a user to ever interact with. It
> would be only useful for people doing platform bringup and other such dirty
> activities. Also, I noticed it is not (yet?) common practice to document
> sysfs entries for fbdev drivers in there. Please let me know your feedback.
> 
> Thanks,
> jaya
> 
> This patch adds waveform storing capability to broadsheetfb. It uses the
> firmware class to retrieve the waveform, and the request to initiate the
> waveform storing is done via a driver sysfs entry, loadstore_waveform.

Please educate me: broadsheet is a framebuffer device, is it not?  What
does it mean to record a waveform into a framebuffer device?  In what
way will a user observe the waveform?  Is it audio?  From the patch it
appears that this mysterious device has flash memory too?

Mystified!
