import subprocess, os, re, urllib.request, sys

sys.stdout.reconfigure(encoding='utf-8', errors='replace')

os.chdir(r'D:\AI建站\goodshoe-b2b')

print('=' * 60)
print('GIT LOG (last 8 commits)')
print('=' * 60)
r = subprocess.run(['git', 'log', '--oneline', '-8'],
                   capture_output=True, text=True, encoding='utf-8', errors='replace')
print(r.stdout)

print('=' * 60)
print('GIT STATUS')
print('=' * 60)
r2 = subprocess.run(['git', 'status'],
                    capture_output=True, text=True, encoding='utf-8', errors='replace')
print(r2.stdout)

print('=' * 60)
print('LIVE DEPLOYED HTML (https://cozy-foot.com/quote)')
print('=' * 60)
req = urllib.request.Request('https://cozy-foot.com/quote',
                             headers={'User-Agent': 'Mozilla/5.0',
                                      'Cache-Control': 'no-cache',
                                      'Pragma': 'no-cache'})
try:
    html = urllib.request.urlopen(req, timeout=20).read().decode('utf-8', errors='replace')
    m_next = re.search(r'name="_next"\s+value="([^"]+)"', html)
    print('LIVE _next value :', m_next.group(1) if m_next else '!!! NOT FOUND !!!')
    print('Has AJAX handler :', 'fetch(form.action' in html)
    print('Has redirect JS  :', "window.location.href = '/thank-you.html'" in html)
    print('Has successCard  :', 'successCard' in html)
    print('Has form.submit():', 'form.submit()' in html)
    print('Has fbq Lead     :', "fbq('track', 'Lead'" in html)
    print('Total HTML bytes :', len(html))
except Exception as e:
    print('ERR:', e)

print()
print('=' * 60)
print('CHECK FORM ACTION AND _next in LOCAL FILES')
print('=' * 60)
for f in [r'D:\AI建站\goodshoe-b2b\quote.html',
          r'D:\AI建站\goodshoe-b2b\es\quote.html']:
    with open(f, 'r', encoding='utf-8') as fh:
        content = fh.read()
    m_act = re.search(r'action="([^"]+)"', content)
    m_next = re.search(r'name="_next"\s+value="([^"]+)"', content)
    print()
    print(f)
    print('  action :', m_act.group(1) if m_act else 'NOT FOUND')
    print('  _next  :', m_next.group(1) if m_next else '!!! NOT FOUND !!!')
    print('  AJAX   :', 'fetch(form.action' in content)
    print('  fallback form.submit():', 'form.submit()' in content)
