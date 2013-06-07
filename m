From: Alex Courbot <acourbot@nvidia.com>
Date: Fri, 07 Jun 2013 06:08:39 +0000
Subject: Re: [PATCH] simplefb: add support for a8b8g8r8 pixel format
Message-Id: <51B178E7.1060802@nvidia.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1370503259-16618-1-git-send-email-acourbot@nvidia.com> <3356BC4D-EEF6-4FCA-9310-5B0727EBF288@jcrosoft.com> <51B0446A.4090305@nvidia.com> <51B0B4A2.4010104@wwwdotorg.org> <20130606162011.GV19468@game.jcrosoft.org> <CAOesGMgybYe_BBb0M4YS8tmM2C5jawf91OOyOuwwS5HSiUjPpQ@mail.gmail.com> <20130606163240.GY19468@game.jcrosoft.org>
In-Reply-To: <20130606163240.GY19468@game.jcrosoft.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
Cc: Olof Johansson <olof@lixom.net>, Stephen Warren <swarren@wwwdotorg.org>, Tomi Valkeinen <tomi.valkeinen@ti.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>, Alexandre Courbot <gnurou@gmail.com>

On 06/07/2013 01:32 AM, Jean-Christophe PLAGNIOL-VILLARD wrote:
>> We're talking about adding a bunch of code instead of one line in a
>> table. Sorry, I NACK your NACK. If we get more entries we'll add the
>> parser, but not just for this.
> as there is no NACK so far I do take as a NACK

... which means?

Anyway, I have sent a new version of this patch that includes a summary 
motivating why we need it. Please explain clearly whether you accept it 
or not, and if not, what we need to do to add this mode in a 
satisfactory way.

Thanks,
Alex.

