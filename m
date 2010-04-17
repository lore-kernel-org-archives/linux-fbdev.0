From: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
Date: Sat, 17 Apr 2010 20:55:23 +0000
Subject: Re: [PATCH 1/7] viafb: package often used basic io functions
Message-Id: <4BCA203B.1000100@gmx.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1271533498-3376-1-git-send-email-FlorianSchandinat@gmx.de> <20100417144008.2bdd49f9@bike.lwn.net>
In-Reply-To: <20100417144008.2bdd49f9@bike.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jonathan Corbet <corbet@lwn.net>
Cc: linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org, JosephChan@via.com.tw, ScottFang@viatech.com.cn

Hi Jon,

Jonathan Corbet schrieb:
> On Sat, 17 Apr 2010 19:44:51 +0000
> Florian Tobias Schandinat <FlorianSchandinat@gmx.de> wrote:
> 
>> This patch puts redesigned versions of the basic io functions that
>> are used overall the driver in an extra header.
> 
> I don't object to the basic idea of these patches, but...as I'm sure
> you can imagine, this stuff will conflict hard with the work I'm trying
> to prepare for submission.  I, too, have had to go in to those
> functions and do things like add locking.  Is there any chance you
> could hold off for just a *little* bit while I get things together?  

Huh, I really didn't expect that to conflict with anything you were 
doing as those are basic functions that are only changed a bit and I 
didn't find anything that would cause any disturbance in some of your trees.
As for locking I'd rather suggest doing it in the caller of these 
functions as they are often bundled together.
Feel free to ignore theses patches if they get in your way. As I said 
the next merge window is mostly for you, I just try to get some stuff in 
that has a near zero regression potential and that I don't expect to 
conflict with yours.

> As I said before, I was traveling this last week.  Now I'm home and can
> get back to this...

Thanks,

Florian Tobias Schandinat
