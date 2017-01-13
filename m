From: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Date: Fri, 13 Jan 2017 11:50:24 +0000
Subject: Re: [PATCH] mm/page_alloc: Wait for oom_lock before retrying.
Message-Id: <20170113115024.GA16506@jagdpanzerIV.localdomain>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20161220153948.GA575@tigerII.localdomain>
 <201612221927.BGE30207.OSFJMFLFOHQtOV@I-love.SAKURA.ne.jp>
 <20161222134250.GE413@tigerII.localdomain>
 <201612222301.AFG57832.QOFMSVFOJHLOtF@I-love.SAKURA.ne.jp>
 <20161222140930.GF413@tigerII.localdomain>
 <201612261954.FJE69201.OFLVtFJSQFOHMO@I-love.SAKURA.ne.jp>
 <20161226113407.GA515@tigerII.localdomain>
 <20170112141844.GA20462@pathway.suse.cz>
 <20170113022843.GA9360@jagdpanzerIV.localdomain>
 <20170113110323.GH14894@pathway.suse.cz>
In-Reply-To: <20170113110323.GH14894@pathway.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Petr Mladek <pmladek@suse.com>
Cc: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>, Sergey Senozhatsky <sergey.senozhatsky@gmail.com>, Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>, mhocko@suse.com, linux-mm@kvack.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.cz>, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

On (01/13/17 12:03), Petr Mladek wrote:
[..]
> > why can't we?
> 
> Because it would newer call cond_resched() in non-preemptive kernel
> with CONFIG_PREEMPT_COUNT disabled. IMHO, we want to call it,
> for example, when we scroll the entire screen from tty_operations.
> 
> Or do I miss anything?

so... basically. it has never called cond_resched() there. right?
why is this suddenly a problem now?

	-ss
