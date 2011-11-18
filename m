From: Tabi Timur-B04825 <B04825@freescale.com>
Date: Fri, 18 Nov 2011 23:53:27 +0000
Subject: Re: [PATCH v3.1] [resend] Resurrect Intel740 driver: i740fb
Message-Id: <CAOZdJXVx88nEAQkL13n1QXVw=kOe03QsD=pffHoZ8gecL7u8dA@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <201111182154.45139.linux@rainbow-software.org>
In-Reply-To: <201111182154.45139.linux@rainbow-software.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Ondrej Zary <linux@rainbow-software.org>
Cc: "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>, Florian Tobias Schandinat <FlorianSchandinat@gmx.de>, Paul Mundt <lethal@linux-sh.org>, Kernel development list <linux-kernel@vger.kernel.org>

On Fri, Nov 18, 2011 at 2:54 PM, Ondrej Zary <linux@rainbow-software.org> wrote:
> Hello,
> this is an v3 attempt to resurrect an old (like 2.4.19) out-of-tree driver for
> Intel740 graphics cards and modify it for recent kernels. The old driver is
> located at: http://sourceforge.net/projects/i740fbdev/files/

Would you please run checkpatch.pl on the patch and fix the complaints
it has?  I get this:

total: 45 errors, 67 warnings, 1619 lines checked

This patch has tons of style problems.

-- 
Timur Tabi
Linux kernel developer at Freescale
