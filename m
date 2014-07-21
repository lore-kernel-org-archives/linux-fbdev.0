From: Pavel Machek <pavel@ucw.cz>
Date: Mon, 21 Jul 2014 21:25:27 +0000
Subject: Re: [PATCH] video: fbdev: uvesafb.c:  Cleaning up variable that is never used
Message-Id: <20140721212527.GC3824@amd.pavel.ucw.cz>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1404564682-21983-1-git-send-email-rickard_strandqvist@spectrumdigital.se>
In-Reply-To: <1404564682-21983-1-git-send-email-rickard_strandqvist@spectrumdigital.se>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Rickard Strandqvist <rickard_strandqvist@spectrumdigital.se>
Cc: Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Rickard Strandqvist <rickard.strandqvist@sonymobile.com>, Wang YanQing <udknight@gmail.com>, Jingoo Han <jg1.han@samsung.com>, Evgeniy Polyakov <zbr@ioremap.net>, Joe Perches <joe@perches.com>, Sachin Kamat <sachin.kamat@linaro.org>, David Fries <David@Fries.net>, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

On Sat 2014-07-05 14:51:22, Rickard Strandqvist wrote:
> From: Rickard Strandqvist <rickard.strandqvist@sonymobile.com>
> 
> Variable ar assigned a value that is never used.
> I have also removed all the code that thereby serves no purpose.
> 
> This was found using a static code analysis program called cppcheck

Are you sure this is right fix?

Should we be returning the error when there's error?
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
