import './style.css'

const profiles = [
  {name:'Urban Fashion ZA', category:'Business', icon:'👗', location:'South Africa', followers:'2.4K', description:'Fashion, clothing and lifestyle inspiration.', featured:true},
  {name:'SoundWave Music', category:'Entertainment', icon:'🎵', location:'Johannesburg', followers:'8.2K', description:'Discover independent musicians and new sounds.', featured:true},
  {name:'Next Level Sports', category:'Sports', icon:'⚽', location:'South Africa', followers:'5.1K', description:'Sports news, athletes and sporting inspiration.', featured:true},
  {name:'Creative Canvas', category:'Arts', icon:'🎨', location:'Cape Town', followers:'1.8K', description:'Art, illustration, photography and design.', featured:true},
  {name:'Digital Creator', category:'Content Creator', icon:'📸', location:'Pretoria', followers:'3.6K', description:'Digital content, videos and creative ideas.'},
  {name:'Smart Academy', category:'Education', icon:'📚', location:'South Africa', followers:'4.3K', description:'Knowledge, tutorials and educational content.'},
  {name:'Tech Universe', category:'Technology', icon:'💻', location:'Durban', followers:'6.7K', description:'Technology, gaming and digital innovation.'},
  {name:'Lifestyle Daily', category:'Lifestyle', icon:'🌍', location:'South Africa', followers:'9.1K', description:'Travel, lifestyle and everyday inspiration.'}
]

const categories = ['All','Business','Entertainment','Sports','Arts','Content Creator','Education','Technology','Lifestyle']

let activeCategory = 'All'
let selectedProfile = null

const app = document.querySelector('#app')

app.innerHTML = `
<header class="header">
  <a href="#" class="logo">FOLLOWERS<span>CLUB.</span></a>
  <button class="join-btn" id="joinTop">Join Club +</button>
</header>

<main>
  <section class="hero">
    <div class="eyebrow">✦ THE COMMUNITY OF GROWTH</div>
    <h1>Grow your audience.<br><span>Find your people.</span></h1>
    <p>Discover real people, connect with creators and grow your community together.</p>

    <div class="search-wrap">
      <span>⌕</span>
      <input id="search" type="search" placeholder="Search creators, businesses, sports...">
    </div>

    <div class="hero-stats">
      <div><strong>REAL</strong><small>People</small></div>
      <div><strong>8</strong><small>Categories</small></div>
      <div><strong>ONE</strong><small>Community</small></div>
    </div>
  </section>

  <section class="featured">
    <div class="section-heading">
      <div>
        <span class="eyebrow">DISCOVER</span>
        <h2>Featured creators</h2>
      </div>
      <span class="scroll-hint">SWIPE →</span>
    </div>
    <div class="carousel" id="carousel"></div>
  </section>

  <section class="directory" id="directory">
    <div class="section-heading">
      <div>
        <span class="eyebrow">YOUR COMMUNITY</span>
        <h2>Explore profiles</h2>
      </div>
      <span class="profile-count" id="count">8 PROFILES</span>
    </div>

    <div class="filters" id="filters"></div>
    <div class="cards" id="cards"></div>
  </section>

  <section class="cta">
    <span class="eyebrow">YOUR JOURNEY STARTS HERE</span>
    <h2>Someone is waiting<br>to discover you.</h2>
    <p>Create your profile and become part of a growing community.</p>
    <button class="primary-btn" id="joinBottom">Create my profile →</button>
  </section>
</main>

<footer>
  <a href="#" class="logo">FOLLOWERS<span>CLUB.</span></a>
  <p>Real people. Real connections. Real growth.</p>
  <div class="footer-links">
    <a href="#directory">Discover</a>
    <a href="#directory">Community</a>
    <a href="mailto:hello@followersclub.co.za">Contact</a>
  </div>
  <small>© 2026 Followers Club. Built for community.</small>
<div class="founder-credit">
<h3>Founder & Creator</h3>
<p>Keitumetse Modisenyane</p>
<p>Born: 08 January 1990</p>
<p>Mokwallo, Vredefort 838, Mandela Section</p>
<p>Contact: 082 542 7103</p>
</div>
</footer>

<div class="modal-backdrop" id="modal">
  <div class="modal" role="dialog" aria-modal="true" aria-labelledby="modalTitle">
    <button class="close" id="closeModal" aria-label="Close">×</button>
    <div id="modalContent"></div>
  </div>
</div>
`

const cards = document.querySelector('#cards')
const carousel = document.querySelector('#carousel')
const filters = document.querySelector('#filters')
const search = document.querySelector('#search')
const modal = document.querySelector('#modal')
const modalContent = document.querySelector('#modalContent')

function cardHTML(p, index) {
  return `
    <article class="profile-card" data-index="${index}">
      <div class="card-top">
        <span class="avatar">${p.icon}</span>
        <span class="verified">✦ MEMBER</span>
      </div>
      <span class="category">${p.category}</span>
      <h3>${p.name}</h3>
      <p>${p.description}</p>
      <div class="card-meta">
        <span>📍 ${p.location}</span>
        <span>♡ ${p.followers}</span>
      </div>
      <button class="view-btn" data-index="${index}">View profile →</button>
    </article>
  `
}

function render() {
  const term = search.value.toLowerCase().trim()

  const results = profiles.map((p,i)=>({...p,index:i})).filter(p =>
    (activeCategory === 'All' || p.category === activeCategory) &&
    [p.name,p.category,p.description,p.location].join(' ').toLowerCase().includes(term)
  )

  cards.innerHTML = results.length
    ? results.map(p=>cardHTML(p,p.index)).join('')
    : '<p class="empty">No profiles found. Try another search.</p>'

  document.querySelector('#count').textContent = `${results.length} PROFILES`
}

function showProfile(p) {
  selectedProfile = p
  modalContent.innerHTML = `
    <div class="modal-avatar">${p.icon}</div>
    <span class="category">${p.category}</span>
    <h2 id="modalTitle">${p.name}</h2>
    <p>${p.description}</p>
    <div class="detail-box">
      <p>📍 ${p.location}</p>
      <p>♡ ${p.followers} community followers (demo data)</p>
    </div>
    <p class="notice">Explore this profile and choose whether to follow its linked social account.</p>
    <button class="primary-btn full" id="registerFromProfile">Create your own profile</button>
  `
  modal.classList.add('open')
  document.querySelector('#registerFromProfile').onclick = showRegistration
}

function showRegistration() {
  modalContent.innerHTML = `
    <span class="eyebrow">JOIN THE COMMUNITY</span>
    <h2 id="modalTitle">Create your profile</h2>
    <p>Introduce yourself to the Followers Club community.</p>
    <form id="registerForm">
      <label>Full name or business name</label>
      <input name="name" required maxlength="70" placeholder="Your name">
      <label>Email address</label>
      <input name="email" type="email" required placeholder="you@example.com">
      <label>Membership type</label>
      <select name="role" required>
        <option value="">Choose your role</option>
        <option>Creator looking for followers</option>
        <option>Community supporter</option>
        <option>Business</option>
        <option>Artist or entertainer</option>
        <option>Sports personality</option>
      </select>
      <label>Category</label>
      <select name="category" required>
        ${categories.filter(c=>c!=='All').map(c=>`<option>${c}</option>`).join('')}
      </select>
      <label>Social media username or profile link</label>
      <input name="social" required maxlength="200" placeholder="@yourusername or profile URL">
      <button class="primary-btn full" type="submit">Create demo profile →</button>
    </form>
    <p class="notice">Demo only: this prototype saves basic profile information on this device. Do not enter sensitive information. Secure account registration will be added with a backend.</p>
  `

  document.querySelector('#registerForm').onsubmit = e => {
    e.preventDefault()
    const data = Object.fromEntries(new FormData(e.target))
    const saved = JSON.parse(localStorage.getItem('fc-profiles') || '[]')
    saved.push({...data,createdAt:new Date().toISOString()})
    localStorage.setItem('fc-profiles',JSON.stringify(saved))
    modalContent.innerHTML = `
      <div class="success-icon">✓</div>
      <h2 id="modalTitle">Welcome to the club!</h2>
      <p>Your demo profile has been saved on this device.</p>
      <button class="primary-btn full" id="done">Done</button>
    `
    document.querySelector('#done').onclick = closeModal
  }
}

function closeModal() {
  modal.classList.remove('open')
}

filters.innerHTML = categories.map(c =>
  `<button class="filter ${c==='All'?'active':''}" data-category="${c}">${c}</button>`
).join('')

carousel.innerHTML = profiles.filter(p=>p.featured).map(p => `
  <article class="feature-card" data-index="${profiles.indexOf(p)}">
    <span class="feature-icon">${p.icon}</span>
    <div><strong>${p.name}</strong><small>${p.category} · ${p.location}</small></div>
    <span>↗</span>
  </article>
`).join('')

filters.onclick = e => {
  const button = e.target.closest('[data-category]')
  if (!button) return
  activeCategory = button.dataset.category
  filters.querySelectorAll('.filter').forEach(b =>
    b.classList.toggle('active',b===button)
  )
  render()
}

search.oninput = render

cards.onclick = e => {
  const button = e.target.closest('[data-index]')
  if (button) showProfile(profiles[Number(button.dataset.index)])
}

carousel.onclick = e => {
  const item = e.target.closest('[data-index]')
  if (item) showProfile(profiles[Number(item.dataset.index)])
}

document.querySelector('#joinTop').onclick = showRegistration
document.querySelector('#joinBottom').onclick = showRegistration
document.querySelector('#closeModal').onclick = closeModal

modal.onclick = e => {
  if (e.target === modal) closeModal()
}

document.addEventListener('keydown',e=>{
  if(e.key === 'Escape') closeModal()
})

render()
