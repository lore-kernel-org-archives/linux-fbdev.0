From: Robert Jarzmik <robert.jarzmik@free.fr>
Date: Tue, 19 Jun 2018 20:11:14 +0000
Subject: Re: [PATCH v2] video: fbdev: pxafb: zero allocated memory for video modes
Message-Id: <878t7ar0yl.fsf@belgarion.home>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20180619131332.23741-1-daniel@zonque.org>
In-Reply-To: <20180619131332.23741-1-daniel@zonque.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Daniel Mack <daniel@zonque.org> writes:

> When parsing the video modes from DT properties, make sure to zero out
> memory befor using it. This is important because not all fields in the mode
s/befor/before/

This taken care of ...
Reviewed-by: Robert Jarzmik <robert.jarzmik@free.fr>

Cheers.

--
Robert
