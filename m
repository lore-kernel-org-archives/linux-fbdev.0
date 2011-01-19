From: Cong Wang <amwang@redhat.com>
Date: Wed, 19 Jan 2011 06:19:56 +0000
Subject: Re: [Patch] video: remove pointless comments in drivers/video/console/vgacon.c
Message-Id: <4D36828C.5030601@redhat.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1295416803-17651-1-git-send-email-amwang@redhat.com> <20110119060257.GA12205@linux-sh.org> <4D367FD6.1010006@redhat.com> <20110119061551.GB12205@linux-sh.org>
In-Reply-To: <20110119061551.GB12205@linux-sh.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Paul Mundt <lethal@linux-sh.org>
Cc: linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Andrew Morton <akpm@linux-foundation.org>, Greg Kroah-Hartman <gregkh@suse.de>, Yannick Heneault <yheneaul@matrox.com>, Matthew Garrett <mjg@redhat.com>, open@linux-sh.org, "\"list@linux-sh.org\"@zmta03.collab.prod.int.phx2.redhat.com:FRAMEBUFFER
	LAYER" <linux-fbdev@vger.kernel.org>

于 2011年01月19日 14:15, Paul Mundt 写道:
> On Wed, Jan 19, 2011 at 02:08:22PM +0800, Cong Wang wrote:
>> ??? 2011???01???19??? 14:02, Paul Mundt ??????:
>>> On Wed, Jan 19, 2011 at 02:00:02PM +0800, Amerigo Wang wrote:
>>>> Now vgacon_scrollback_startup() uses slab, not bootmem,
>>>> so that comment is obsolete, the rest are useless.
>>>>
>>>> Signed-off-by: WANG Cong<amwang@redhat.com>
>>>>
>>> If you're going to do this then at least follow through and do the rest
>>> of it. The comment is no longer applicable, but then neither is the
>>> __init_refok annotation. Killing off the comment explaining why something
>>> is (or was there) without killing off the thing that is referenced by the
>>> comment is not terribly productive.
>>
>> Isn't __init_refok already a clear sign of "silence modpost"?
>> Why need to comment it again?
>
> __init_refok was to silence what was presumably an alloc_bootmem()
> reference at the time that the slab allocations were not early enough to
> satisfy the allocation, necessitating the use of bootmem. Since kmalloc
> and friends became usable early enough and the bootmem allocation has
> subsequently been dropped, there's no longer any need for the annotation.
>
> ie, alloc_bootmem() itself is __init while vgacon_scrollback_startup() is
> not, hence the modpost complaint.

Ah, I see, will remove '__init_refok' as well.

Thanks!
