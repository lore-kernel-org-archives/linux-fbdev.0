From: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
Date: Wed, 14 Sep 2011 22:19:07 +0000
Subject: Re: [REPOST][PATCH 1/2] fbdev: fix indentation in modedb.c
Message-Id: <4E71285B.6080401@gmx.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1315929909-26311-1-git-send-email-timur@freescale.com>
In-Reply-To: <1315929909-26311-1-git-send-email-timur@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

On 09/14/2011 09:47 PM, Timur Tabi wrote:
> Florian Tobias Schandinat wrote:
>> Applied this patch, although I do not like this sort of patches very much. Well,
>> I guess it's an improvement, are you doing some real work on this code?
> 
> Ugh, please ignore my previous reply.  For some reason, I thought you were
> talking about my second patch.

No problem. Are you going to answer Tormod's email?
I agree with him, that those should have been separate patches and I wasn't sure
whether to reject it or accept it one last time (future patches with such a list
in the commit message will be rejected for sure). I guess I might let it slip
through this time but at least answer to the type of edid.

> To answer your question properly: no, I'm not doing any real work on this code.
>  I noticed the bad indentation, and I decided that maybe it was worth fixing.
> Yes, it might cause some pain with diffs, but these functions have been around a
> long time and haven't been touched in while.  Also, a similar patch to mine was
> applied recently: "video: tidy up modedb formatting."

Okay, I admit that it might have improved readability and by using "diff -b"
most of it was easy reviewable. The thing that really costs me some time was
checking the braces after your removal of
else {
after an if-statement that included a return.
Such patches are not always bad, but they have less priority than real changes
and I really wouldn't recommend anyone to try "fixing" any checkpatch warning
inside the kernel source.


Best regards,

Florian Tobias Schandinat
