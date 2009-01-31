From: Andrea Righi <righi.andrea@gmail.com>
Subject: Re: [Linux-fbdev-devel] [2.6.29-rc2] fb_mmap: circular locking dependency
 on hibernation
Date: Sat, 31 Jan 2009 19:11:55 +0100
Message-ID: <4984946B.5000205@gmail.com>
References: <200901272137.57757.arvidjaar@mail.ru> <Pine.LNX.4.64.0901291009220.13600@anakin> <200901300716.06137.arvidjaar@mail.ru> <498485E0.4080501@gmail.com> <Pine.LNX.4.64.0901311843450.21273@anakin>
Reply-To: righi.andrea@gmail.com
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1754515AbZAaSMS@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.64.0901311843450.21273@anakin>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <fbdev-devel.lists.sourceforge.net>
Content-Type: text/plain; charset="us-ascii"
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Andrey Borzenkov <arvidjaar@mail.ru>, Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>, "Antonino A. Daplas" <adaplas@gmail.com>, linux-pm@lists.linux-foundation.org, Linux Kernel Development <linux-kernel@vger.kernel.org>

On 2009-01-31 18:44, Geert Uytterhoeven wrote:
> On Sat, 31 Jan 2009, Andrea Righi wrote:
>> On 2009-01-30 05:15, Andrey Borzenkov wrote:
>>> On 29 of January 2009 12:10:11 Geert Uytterhoeven wrote:
>>>> On Tue, 27 Jan 2009, Andrey Borzenkov wrote:
>> fbcon: avoid circular locking dependency between fb_info->lock and mm->mmap_sem
>>
>> In fbcon notifier the handler for FB_EVENT_SET_CONSOLE_MAP doesn't need
>> to hold fb_info->lock.
>>
>> Simply unlock it before calling set_con2fb_map(), that could try to
>> acquire mm->mmap_sem to avoid a circular locking dependency with
>> fb_mmap() (that acquires mm->mmap_sem -> fb_info-lock).
> 
> However, set_con2fb_map() accesses the array of fb_info pointers
> registered_fb[], which seems to be a bit unsafe now the BKL is no longer held.

mmmh.. not sure about that, registered_fb[] was never accessed with
fb_info->lock held, see register/unregister_framebuffer().

But maybe this is another issue, and anyway, the array and also
num_registered_fb don't seem to be protected at all...

-Andrea
