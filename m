From: Behan Webster <behanw@converseincode.com>
Date: Sat, 27 Sep 2014 22:53:56 +0000
Subject: Re: [PATCH 1/2] arm, fbdev, omap2, LLVMLinux: Remove nested function from omap2 dss
Message-Id: <54274004.6010902@converseincode.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1411780253-4492-1-git-send-email-behanw@converseincode.com> <1411780253-4492-2-git-send-email-behanw@converseincode.com> <20140927164554.GA7076@saruman>
In-Reply-To: <20140927164554.GA7076@saruman>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: balbi@ti.com
Cc: plagnioj@jcrosoft.com, tomi.valkeinen@ti.com, daniel.vetter@ffwll.ch, geert@linux-m68k.org, laurent.pinchart@ideasonboard.com, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, robdclark@gmail.com, Arnd Bergmann <arnd@arndb.de>

On 09/27/14 09:46, Felipe Balbi wrote:
> On Fri, Sep 26, 2014 at 06:10:52PM -0700, Behan Webster wrote:
>> Replace the use of nested functions where a normal function will suffice.
>>
>> Nested functions are not liked by upstream kernel developers in general. Their
>> use breaks the use of clang as a compiler, and doesn't make the code any
>> better.
>>
>> This code now works for both gcc and clang.
>>
>> Signed-off-by: Behan Webster <behanw@converseincode.com>
>> Suggested-by: Arnd Bergmann <arnd@arndb.de>
>> Cc: Arnd Bergmann <arnd@arndb.de>
> another one that make sense :-) And probably also deserves
> checkpatch/coccinelle/sparse.
Indeed! That would be very appreciated.

The clang static analyzer already points this one out. :)

Behan

-- 
Behan Webster
behanw@converseincode.com

