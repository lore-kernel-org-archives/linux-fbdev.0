From: Julia Lawall <julia.lawall@lip6.fr>
Date: Fri, 29 Mar 2013 06:21:07 +0000
Subject: Re: [PATCH] compat/compat-drivers/linux-next: fb skip_vt_switch
Message-Id: <alpine.DEB.2.02.1303290720350.2023@localhost6.localdomain6>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1364472270-9297-1-git-send-email-mcgrof@do-not-panic.com> <20130328083943.01e61b4b@jbarnes-desktop> <alpine.DEB.2.02.1303281718490.1928@hadrien> <CAB=NE6WbNwPqEPYsASAPaECe4qbAWdd4=eJ402ib+CzZbT69=g@mail.gmail.com> <alpine.DEB.2.02.1303281909570.1928@hadrien>
 <CAB=NE6VPRu8DvneVdwd=pXF0ngi5OifNTpZtX3pLi50i116_OA@mail.gmail.com> <alpine.DEB.2.02.1303282328200.2022@localhost6.localdomain6> <CAB=NE6WX5Dv9p2jrNwe9GxfH=EUm596uvSspsLQ5-Uuonc6Fqg@mail.gmail.com>
In-Reply-To: <CAB=NE6WX5Dv9p2jrNwe9GxfH=EUm596uvSspsLQ5-Uuonc6Fqg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Cc: Julia Lawall <julia.lawall@lip6.fr>, Jesse Barnes <jbarnes@virtuousgeek.org>, florianschandinat <FlorianSchandinat@gmx.de>, linux-fbdev <linux-fbdev@vger.kernel.org>, dri-devel@lists.freedesktop.org, "backports@vger.kernel.org" <backports@vger.kernel.org>, cocci@systeme.lip6.fr, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "rodrigo.vivi" <rodrigo.vivi@gmail.com>, Daniel Vetter <daniel.vetter@ffwll.ch>, "rafael.j.wysocki" <rafael.j.wysocki@intel.com>

> > I looked in today's linux-next, and there seems to be only one
> > initialization of this field, to true, and one test of this field.  So
> > perhaps the case for setting the field to false just isn't needed.
> 
> Oh sorry now I get what you mean! I thought about this -- and yes I
> decided to not add a bool false setting for the structure field given
> that the assumption is this would not be something dynamic, and data
> structure would be kzalloc()'d so by default they are 0.

What do you do about the test, though?

julia
