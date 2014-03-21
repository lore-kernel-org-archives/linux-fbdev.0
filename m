From: Ivan Drobyshevskyi <drobyshevskyi@gmail.com>
Date: Fri, 21 Mar 2014 14:30:15 +0000
Subject: How to make framebuffer look like a real monitor?
Message-Id: <CADAXeK1HznKm6AuWa1431i0u+GSKkXq0u3FWMFvbHU95FJQbzg@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Is there a way to make X treat Linux framebuffer device (e.g. /dev/fb0
backed by virtual framebuffer) as a real display? Ideally it should
appear in system display settings as a configurable monitor. Does it
require writing some kernel code or it's possible to somehow get away
with for example X configuration?

Thanks,
Ivan.
