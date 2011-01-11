From: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Date: Tue, 11 Jan 2011 17:35:09 +0000
Subject: Re: Memory sharing issue by application on V4L2 based device
Message-Id: <20110111173509.GB14017@dumpdata.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <4D25BC22.6080803@samsung.com>
 <AANLkTi=P8qY22saY9a_-rze1wsr-DLMgc6Lfa6qnfM7u@mail.gmail.com>
 <002201cbadfd$6d59e490$480dadb0$%han@samsung.com>
 <AANLkTinsduJkynwwEeM5K9f3D7C6jtBgkAyZ0-_0z2X-@mail.gmail.com>
 <003201cbae19$bda3dfc0$38eb9f40$%han@samsung.com>
In-Reply-To: <003201cbae19$bda3dfc0$38eb9f40$%han@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jonghun Han <jonghun.han@samsung.com>
Cc: 'InKi Dae' <daeinki@gmail.com>, linux-media@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 'linux-fbdev' <linux-fbdev@vger.kernel.org>, kyungmin.park@samsung.com


 .. snip..
> But 64KB or 1MB physically contiguous memory is better than 4KB page in the
> point of performance.

Could you explain that in more details please? I presume you are
talking about a CPU that has a MMU unit, right?
